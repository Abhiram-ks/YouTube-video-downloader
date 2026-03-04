
import 'package:videodownload/core/service/youtube_explode_service.dart';
import 'package:videodownload/src/domain/entity/video_details.dart';
import 'package:videodownload/src/domain/repo/video_repo.dart';

class VideoRepositoryImpl implements VideoRepository {
  final YoutubeExplodeService _youtubeService;

  VideoRepositoryImpl({YoutubeExplodeService? youtubeService})
    : _youtubeService = youtubeService ?? YoutubeExplodeService();

  @override
  Future<VideoDetails> getVideoDetails(String url) async {
    return await _youtubeService.getVideoDetails(url);
  }
}
