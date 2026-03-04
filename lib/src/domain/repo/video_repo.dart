import 'package:videodownload/src/domain/entity/video_details.dart';

abstract class VideoRepository {
  Future<VideoDetails> getVideoDetails(String url);
}
