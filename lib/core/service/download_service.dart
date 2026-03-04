import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'package:dio/dio.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:videodownload/core/helper/isolate_helper.dart';
import 'package:videodownload/src/data/local/model/downloaded_video_model.dart';
import 'package:videodownload/src/domain/entity/video_details.dart';

/// Request object sent to the background isolate
class DownloadRequest {
  final String url;
  final String savePath;
  final String videoId;
  final SendPort sendPort;

  DownloadRequest({
    required this.url,
    required this.savePath,
    required this.videoId,
    required this.sendPort,
  });
}

class DownloadService {
  final Isar isar;

  final Map<String, Isolate> _activeIsolates = {};
  final Map<String, StreamSubscription> _activeSubscriptions = {};
  final Map<String, ReceivePort> _activePorts = {};

  DownloadService(this.isar);

  Future<void> startDownload(
    VideoDetails video,
    VideoQualityOption quality,
  ) async {
    await _cleanupActiveDownload(video.id);

    // 2. Prepare paths
    final directory = await getApplicationDocumentsDirectory();
    String sanitize(String value) =>
        value.replaceAll(RegExp(r'[^\w\-\.]'), '_');

    final fileName =
        "video_${sanitize(video.id)}_${sanitize(quality.qualityLabel)}.mp4";
    final finalPath = "${directory.path}/$fileName";

    // 3. Update/Create DB record
    final model = DownloadedVideoModel()
      ..videoId = video.id
      ..title = video.title
      ..author = video.author
      ..thumbnailUrl = video.thumbnailUrl
      ..logo = video.logo
      ..durationInSeconds = video.duration.inSeconds
      ..filePath = finalPath
      ..qualityLabel = quality.qualityLabel
      ..sizeInBytes = quality.sizeInBytes
      ..downloadedAt = DateTime.now()
      ..status = DownloadStatus.processing
      ..progress = 0;

    await isar.writeTxn(() async {
      await isar.downloadedVideoModels.put(model);
    });

    // 4. Set up communication ports
    final receivePort = ReceivePort();
    _activePorts[video.id] = receivePort;

    // 5. Spawn Isolate
    final isolate = await IsolateHelper.run(
      worker: _downloadWorker,
      data: DownloadRequest(
        url: quality.url,
        savePath: finalPath,
        videoId: video.id,
        sendPort: receivePort.sendPort,
      ),
    );

    _activeIsolates[video.id] = isolate;

    // 6. Listen for worker updates
    final subscription = receivePort.listen((message) async {
      if (message is Map<String, dynamic>) {
        final String type = message['type'];
        final String vidId = message['videoId'];

        if (type == 'progress') {
          final int progress = message['progress'];
          await _updateDB(vidId, progress, DownloadStatus.processing);
        } else if (type == 'success') {
          await _cleanupActiveDownload(vidId);
          await _updateDB(vidId, 100, DownloadStatus.completed);
        } else if (type == 'error') {
          await _cleanupActiveDownload(vidId);
          await _updateDB(vidId, 0, DownloadStatus.retry);
        }
      }
    });

    _activeSubscriptions[video.id] = subscription;
  }

  Future<void> cancelDownload(String videoId) async {
    await _cleanupActiveDownload(videoId);

    final existing = await isar.downloadedVideoModels
        .filter()
        .videoIdEqualTo(videoId)
        .findFirst();

    if (existing != null) {
      await _updateDB(videoId, 0, DownloadStatus.canceled);
      try {
        final file = File(existing.filePath);
        if (await file.exists()) {
          await file.delete();
        }
      } catch (_) {
        // Log error if file deletion fails
      }
    }
  }

  /// Kills the isolate, cancels subscription, and closes ports
  Future<void> _cleanupActiveDownload(String videoId) async {
    final subscription = _activeSubscriptions.remove(videoId);
    if (subscription != null) await subscription.cancel();

    final port = _activePorts.remove(videoId);
    if (port != null) port.close();

    final isolate = _activeIsolates.remove(videoId);
    if (isolate != null) {
      isolate.kill(priority: Isolate.immediate);
    }
  }

  /// Updates Isar DB with thread safety and status protection
  Future<void> _updateDB(
    String videoId,
    int progress,
    DownloadStatus status,
  ) async {
    try {
      await isar.writeTxn(() async {
        final existing = await isar.downloadedVideoModels
            .filter()
            .videoIdEqualTo(videoId)
            .findFirst();

        if (existing != null) {
          // If the record is already completed or canceled, don't allow progress updates to overwrite it
          if (existing.status == DownloadStatus.completed ||
              existing.status == DownloadStatus.canceled) {
            // Only allow status changes to 'completed' or 'canceled' if we are actually at that stage
            if (status == DownloadStatus.processing) return;
          }

          // If we are currently processing, ensure we don't go backwards in progress
          if (status == DownloadStatus.processing &&
              existing.status == DownloadStatus.processing &&
              progress <= existing.progress) {
            return;
          }

          existing.progress = progress;
          existing.status = status;
          await isar.downloadedVideoModels.put(existing);
        }
      });
    } catch (e) {
      // In production, consider logging this via a logger service
      stdout.writeln('DownloadService: DB Update failed for $videoId - $e');
    }
  }

  /// The Worker Isolate Entry Point (Static/Top-Level)
  static void _downloadWorker(dynamic data) async {
    if (data is! DownloadRequest) return;

    final request = data;
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(minutes: 20),
      ),
    );

    int lastProgress = -1;
    DateTime lastUpdate = DateTime.now();

    try {
      // Ensure directory exists
      final saveFile = File(request.savePath);
      final dir = saveFile.parent;
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }

      await dio.download(
        request.url,
        request.savePath,
        onReceiveProgress: (received, total) {
          if (total <= 0) return;

          final progress = ((received / total) * 100).toInt();
          final now = DateTime.now();

          // Throttling: Update only if progress changed AND enough time passed OR it's 100%
          if (progress > lastProgress &&
              (now.difference(lastUpdate).inMilliseconds > 500 ||
                  progress == 100)) {
            lastProgress = progress;
            lastUpdate = now;

            request.sendPort.send({
              'type': 'progress',
              'progress': progress,
              'videoId': request.videoId,
            });
          }
        },
      );

      // Final verification
      if (await saveFile.exists() && await saveFile.length() > 0) {
        request.sendPort.send({'type': 'success', 'videoId': request.videoId});
      } else {
        throw Exception("Downloaded file is missing or empty");
      }
    } catch (e) {
      // Cleanup partial file on error
      try {
        final file = File(request.savePath);
        if (await file.exists()) await file.delete();
      } catch (_) {}

      request.sendPort.send({
        'type': 'error',
        'videoId': request.videoId,
        'error': e.toString(),
      });
    } finally {
      dio.close();
    }
  }
}
