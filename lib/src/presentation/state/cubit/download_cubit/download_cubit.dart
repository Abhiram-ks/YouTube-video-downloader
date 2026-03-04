import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:videodownload/core/service/download_service.dart';
import 'package:videodownload/core/service/youtube_explode_service.dart';
import 'package:videodownload/src/data/local/model/downloaded_video_model.dart';
import 'package:videodownload/src/domain/entity/video_details.dart';

sealed class DownloadState extends Equatable {
  const DownloadState();
  @override
  List<Object?> get props => [];
}

final class DownloadInitial extends DownloadState {}

final class DownloadInProgress extends DownloadState {
  final String videoId;
  final int progress;
  const DownloadInProgress(this.videoId, this.progress);
  @override
  List<Object?> get props => [videoId, progress];
}

final class DownloadSuccess extends DownloadState {
  final String videoId;
  const DownloadSuccess(this.videoId);
  @override
  List<Object?> get props => [videoId];
}

final class DownloadFailure extends DownloadState {
  final String error;
  const DownloadFailure(this.error);
  @override
  List<Object?> get props => [error];
}

class DownloadCubit extends Cubit<DownloadState> {
  final DownloadService _downloadService;
  final YoutubeExplodeService _youtubeService;

  DownloadCubit(this._downloadService, this._youtubeService)
    : super(DownloadInitial());

  Future<void> startDownload(
    VideoDetails video,
    VideoQualityOption quality,
  ) async {
    try {
      await _downloadService.startDownload(video, quality);
    } catch (e) {
      emit(DownloadFailure(e.toString()));
    }
  }

  Future<void> retryLibraryDownload(DownloadedVideoModel videoModel) async {
    try {
      final details = await _youtubeService.getVideoDetails(
        "https://www.youtube.com/watch?v=${videoModel.videoId}",
      );

      final quality = details.qualityOptions.firstWhere(
        (q) => q.qualityLabel == videoModel.qualityLabel,
        orElse: () => details.qualityOptions.first,
      );

      await startDownload(details, quality);
    } catch (e) {
      emit(DownloadFailure("Retry failed: ${e.toString()}"));
    }
  }

  Future<void> cancelDownload(String videoId) async {
    await _downloadService.cancelDownload(videoId);
  }
}
