import 'dart:async';
import 'dart:io';
import 'package:background_downloader/background_downloader.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:videodownload/core/service/gallery_service.dart';
import 'package:videodownload/src/data/local/model/downloaded_video_model.dart';
import 'package:videodownload/src/domain/entity/video_details.dart';

class DownloadService {
  final Isar isar;
  final GalleryService _galleryService;
  StreamSubscription<TaskUpdate>? _updatesSubscription;

  DownloadService({required this.isar, required GalleryService galleryService})
    : _galleryService = galleryService {
    _initialize();
  }

  void _initialize() {
    FileDownloader().configure(
      globalConfig: [(Config.requestTimeout, const Duration(seconds: 30))],
    );

    FileDownloader().trackTasks();

    _updatesSubscription = FileDownloader().updates.listen((update) {
      if (update is TaskStatusUpdate) {
        _handleStatusUpdate(update);
      } else if (update is TaskProgressUpdate) {
        _handleProgressUpdate(update);
      }
    });
  }

  Future<void> startDownload(
    VideoDetails video,
    VideoQualityOption quality,
  ) async {
    final directory = await getApplicationDocumentsDirectory();
    String sanitize(String value) =>
        value.replaceAll(RegExp(r'[^\w\-\.]'), '_');

    final fileName =
        "video_${sanitize(video.id)}_${sanitize(quality.qualityLabel)}.mp4";
    const subDirectory = 'downloads';

    final fullDirPath = "${directory.path}/$subDirectory";
    final dir = Directory(fullDirPath);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    final finalPath = "$fullDirPath/$fileName";

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

    final task = DownloadTask(
      taskId: video.id,
      url: quality.url,
      filename: fileName,
      directory: subDirectory,
      baseDirectory: BaseDirectory.applicationDocuments,
      updates: Updates.statusAndProgress,
      retries: 3,
      allowPause: true,
      metaData: video.id,
    );

    await FileDownloader().enqueue(task);
  }

  Future<void> cancelDownload(String videoId) async {
    await FileDownloader().cancelTasksWithIds([videoId]);

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

  void _handleStatusUpdate(TaskStatusUpdate update) async {
    final videoId = update.task.taskId;

    switch (update.status) {
      case TaskStatus.complete:
        await _updateDB(videoId, 100, DownloadStatus.completed);
        break;
      case TaskStatus.canceled:
        await _updateDB(videoId, 0, DownloadStatus.canceled);
        break;
      case TaskStatus.failed:
      case TaskStatus.notFound:
        await _updateDB(videoId, 0, DownloadStatus.retry);
        break;
      case TaskStatus.waitingToRetry:
        await _updateDB(videoId, 0, DownloadStatus.processing);
        break;
      default:
        break;
    }
  }

  void _handleProgressUpdate(TaskProgressUpdate update) async {
    final videoId = update.task.taskId;

    if (update.progress >= 0 && update.progress <= 1.0) {
      final int progressPercent = (update.progress * 100).toInt();
      await _updateDB(videoId, progressPercent, DownloadStatus.processing);
    }
  }

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
          if (existing.status == DownloadStatus.completed) {
            if (status == DownloadStatus.processing) return;
          }

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
      stderr.writeln('DownloadService: DB Update failed for $videoId - $e');
    }
  }

  Future<bool> isDownloading(String videoId) async {
    final record = await FileDownloader().database.recordForId(videoId);
    if (record == null) return false;

    return record.status == TaskStatus.enqueued ||
        record.status == TaskStatus.running ||
        record.status == TaskStatus.waitingToRetry;
  }

  Future<void> pauseDownload(String videoId) async {
    final task = await FileDownloader().taskForId(videoId);
    if (task is DownloadTask) {
      await FileDownloader().pause(task);
    }
  }

  Future<void> resumeDownload(String videoId) async {
    final task = await FileDownloader().taskForId(videoId);
    if (task is DownloadTask) {
      await FileDownloader().resume(task);
    }
  }

  Future<void> saveToGallery(String videoId) async {
    final existing = await isar.downloadedVideoModels
        .filter()
        .videoIdEqualTo(videoId)
        .findFirst();

    if (existing == null) {
      throw Exception('Video not found in database');
    }

    await _galleryService.saveVideo(existing.filePath);
  }

  void dispose() {
    _updatesSubscription?.cancel();
  }
}
