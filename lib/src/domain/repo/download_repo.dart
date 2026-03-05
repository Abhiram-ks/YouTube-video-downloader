import 'package:videodownload/src/domain/entity/video_details.dart';

abstract class DownloadRepository {
  Future<void> startDownload(VideoDetails video, VideoQualityOption quality);
  Future<void> cancelDownload(String videoId);
  Future<bool> isDownloading(String videoId);
  Future<void> pauseDownload(String videoId);
  Future<void> resumeDownload(String videoId);
  Future<void> saveToGallery(String videoId);
}
