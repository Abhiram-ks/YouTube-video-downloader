import 'package:videodownload/src/domain/entity/video_details.dart';
import 'package:videodownload/src/domain/repo/video_repo.dart';

class VideoUsecase {
  final VideoRepository videoRepository;
  VideoUsecase({required this.videoRepository});

  Future<VideoDetails> call(String url) async {
    return await videoRepository.getVideoDetails(url);
  }
}