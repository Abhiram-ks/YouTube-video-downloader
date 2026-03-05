import 'package:videodownload/src/domain/entity/video_details.dart';
import 'package:videodownload/src/domain/repo/download_repo.dart';

class DownloadUseCase {
  final DownloadRepository _downloadRepository;

  DownloadUseCase({required DownloadRepository downloadRepository})
    : _downloadRepository = downloadRepository;

  Future<void> startDownload(VideoDetails video, VideoQualityOption quality) {
    return _downloadRepository.startDownload(video, quality);
  }

  Future<void> cancelDownload(String videoId) {
    return _downloadRepository.cancelDownload(videoId);
  }

  Future<bool> isDownloading(String videoId) {
    return _downloadRepository.isDownloading(videoId);
  }

  Future<void> pauseDownload(String videoId) {
    return _downloadRepository.pauseDownload(videoId);
  }

  Future<void> resumeDownload(String videoId) {
    return _downloadRepository.resumeDownload(videoId);
  }

  Future<void> saveToGallery(String videoId) {
    return _downloadRepository.saveToGallery(videoId);
  }
}
