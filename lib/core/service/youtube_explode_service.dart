
import 'dart:io';
import 'package:videodownload/core/error/youtube_exeption.dart';
import 'package:videodownload/src/domain/entity/video_details.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeExplodeService {
  YoutubeExplodeService._internal();

  static final YoutubeExplodeService _instance =
      YoutubeExplodeService._internal();

  factory YoutubeExplodeService() => _instance;

  final YoutubeExplode _yt = YoutubeExplode();

  Future<VideoDetails> getVideoDetails(String url) async {
    final sanitizedUrl = url.trim();

    if (sanitizedUrl.isEmpty) {
      throw YoutubeServiceException('The YouTube URL cannot be empty.');
    }

    try {
      final video = await _yt.videos.get(sanitizedUrl);
      final manifest = await _yt.videos.streamsClient.getManifest(video.id);
      final qualityOptions = manifest.muxed.map((stream) {
        return VideoQualityOption(
          qualityLabel: stream.qualityLabel,
          url: stream.url.toString(),
          sizeInBytes: stream.size.totalBytes,
        );
      }).toList();

      if (qualityOptions.isEmpty) {
        throw YoutubeServiceException(
          "This video isn't available for download.",
        );
      }

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
        "Video unavailable: It may be private or restricted.",
      );
    } on ArgumentError catch (e) {
      throw YoutubeServiceException("Check your link: ${e.message}");
    } on SocketException {
      throw YoutubeServiceException("No internet connection");
    } catch (e) {
      final errorStr = e.toString().toLowerCase();

      if (errorStr.contains('429') || errorStr.contains('too many requests')) {
        throw YoutubeServiceException(
          "Too many requests.",
        );
      }

      if (errorStr.contains('invalid video id') ||
          errorStr.contains('not a valid youtube url')) {
        throw YoutubeServiceException("Please enter a valid YouTube URL.");
      }

      if (errorStr.contains('video is unavailable')) {
        throw YoutubeServiceException("This video is currently unavailable.");
      }

      throw YoutubeServiceException(
        "Could not analyze video. Please try again.",
      );
    }
  }

  void dispose() {
    _yt.close();
  }
}
