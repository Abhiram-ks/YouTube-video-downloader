import 'dart:io';
import 'package:videodownload/src/domain/entity/video_details.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

/// Exception thrown when something goes wrong in [YoutubeExplodeService].
class YoutubeServiceException implements Exception {
  final String message;
  final dynamic originalError;

  YoutubeServiceException(this.message, [this.originalError]);

  @override
  String toString() => message;
}

class YoutubeExplodeService {
  // --- Singleton Pattern Implementation ---

  /// Private constructor
  YoutubeExplodeService._internal();

  /// The internal singleton instance
  static final YoutubeExplodeService _instance =
      YoutubeExplodeService._internal();

  /// Factory constructor returns the same [YoutubeExplodeService] instance.
  factory YoutubeExplodeService() => _instance;

  final YoutubeExplode _yt = YoutubeExplode();

  /// Fetches [VideoDetails] for a given YouTube URL.
  ///
  /// Throws [YoutubeServiceException] with clear, user-friendly messages for different
  /// failure scenarios (invalid URL, unavailable video, network issues, etc.).
  Future<VideoDetails> getVideoDetails(String url) async {
    final sanitizedUrl = url.trim();

    if (sanitizedUrl.isEmpty) {
      throw YoutubeServiceException('The YouTube URL cannot be empty.');
    }

    try {
      final video = await _yt.videos.get(sanitizedUrl);

      // Get manifest for stream info (quality, size, etc.)
      final manifest = await _yt.videos.streamsClient.getManifest(video.id);

      // Map muxed streams (video + audio) to our VideoQualityOption entity
      final qualityOptions = manifest.muxed.map((stream) {
        return VideoQualityOption(
          qualityLabel: stream.qualityLabel,
          url: stream.url.toString(),
          sizeInBytes: stream.size.totalBytes,
        );
      }).toList();

      if (qualityOptions.isEmpty) {
        throw YoutubeServiceException(
          'No downloadable video streams were found for this URL.',
        );
      }

      // Fetch channel details to get the creator's logo
      final channel = await _yt.channels.get(video.channelId);

      return VideoDetails(
        id: video.id.value,
        title: video.title,
        author: video.author,
        logo: channel.logoUrl,
        thumbnailUrl: video.thumbnails.highResUrl,
        duration: video.duration ?? Duration.zero,
        qualityOptions: qualityOptions,
      );
    } on VideoUnavailableException {
      throw YoutubeServiceException(
        'This video is unavailable (it may be private, deleted, or restricted).',
      );
    } on ArgumentError catch (e) {
      throw YoutubeServiceException(
        'The YouTube link is invalid: ${e.message}',
      );
    } on SocketException {
      throw YoutubeServiceException(
        'Network connection error. Please check your internet and try again.',
      );
    } catch (e) {
      final errorStr = e.toString().toLowerCase();

      if (errorStr.contains('invalid video id') ||
          errorStr.contains('not a valid youtube url')) {
        throw YoutubeServiceException(
          'The link you entered is not a valid YouTube URL.',
        );
      }

      if (errorStr.contains('video is unavailable')) {
        throw YoutubeServiceException('This video is currently unavailable.');
      }

      throw YoutubeServiceException(
        'An unexpected error occurred while analyzing the video. Please try again.',
        e,
      );
    }
  }

  /// Closes the [YoutubeExplode] client instance.
  void dispose() {
    _yt.close();
  }
}
