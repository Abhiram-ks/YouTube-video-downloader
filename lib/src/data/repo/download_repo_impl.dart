import 'package:videodownload/core/service/download_service.dart';
import 'package:videodownload/src/domain/entity/video_details.dart';
import 'package:videodownload/src/domain/repo/download_repo.dart';

class DownloadRepositoryImpl implements DownloadRepository {
  final DownloadService _downloadService;

  DownloadRepositoryImpl({required DownloadService downloadService})
    : _downloadService = downloadService;

  @override
  Future<void> startDownload(VideoDetails video, VideoQualityOption quality) {
    return _downloadService.startDownload(video, quality);
  }

  @override
  Future<void> cancelDownload(String videoId) {
    return _downloadService.cancelDownload(videoId);
  }

  @override
  Future<bool> isDownloading(String videoId) {
    return _downloadService.isDownloading(videoId);
  }

  @override
  Future<void> pauseDownload(String videoId) {
    return _downloadService.pauseDownload(videoId);
  }

  @override
  Future<void> resumeDownload(String videoId) {
    return _downloadService.resumeDownload(videoId);
  }

  @override
  Future<void> saveToGallery(String videoId) {
    return _downloadService.saveToGallery(videoId);
  }
}
