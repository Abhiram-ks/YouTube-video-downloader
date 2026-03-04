import 'package:bizforz/src/domain/entity/video_details.dart';
import 'package:bizforz/src/domain/repo/video_repo.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoRepositoryImpl implements VideoRepository {
  final YoutubeExplode _yt = YoutubeExplode();

  @override
  Future<VideoDetails> getVideoDetails(String url) async {
    try {
      final video = await _yt.videos.get(url);
      final manifest = await _yt.videos.streamsClient.getManifest(video.id);

      final qualityOptions = manifest.muxed.map((stream) {
        return VideoQualityOption(
          qualityLabel: stream.qualityLabel,
          url: stream.url.toString(),
          sizeInBytes: stream.size.totalBytes,
        );
      }).toList();

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
    } catch (e) {
      throw Exception('Failed to fetch video details: $e');
    }
  }

  void dispose() {
    _yt.close();
  }
}
