import 'package:bizforz/src/domain/entity/video_details.dart';

abstract class VideoRepository {
  Future<VideoDetails> getVideoDetails(String url);
}
