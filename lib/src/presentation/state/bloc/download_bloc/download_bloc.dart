import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:videodownload/core/service/download_service.dart';
import 'package:videodownload/core/service/youtube_explode_service.dart';
import 'package:videodownload/src/data/local/model/downloaded_video_model.dart';
import 'package:videodownload/src/domain/entity/video_details.dart';

part 'download_event.dart';
part 'download_state.dart';

class DownloadBloc extends Bloc<DownloadEvent, DownloadState> {
  final DownloadService _downloadService;
  final YoutubeExplodeService _youtubeService;

  DownloadBloc({
    required DownloadService downloadService,
    required YoutubeExplodeService youtubeService,
  }) : _downloadService = downloadService,
       _youtubeService = youtubeService,
       super(DownloadInitial()) {
    on<StartDownloadEvent>(_onStartDownload);
    on<RetryDownloadEvent>(_onRetryDownload);
    on<CancelDownloadEvent>(_onCancelDownload);
  }

  Future<void> _onStartDownload(
    StartDownloadEvent event,
    Emitter<DownloadState> emit,
  ) async {
    try {
      await _downloadService.startDownload(event.video, event.quality);
    } catch (e) {
      emit(DownloadFailure(error: e.toString()));
    }
  }

  Future<void> _onRetryDownload(
    RetryDownloadEvent event,
    Emitter<DownloadState> emit,
  ) async {
    emit(const DownloadLoading());
    try {
      await (() async {
        final details = await _youtubeService.getVideoDetails(
          "https://www.youtube.com/watch?v=${event.videoModel.videoId}",
        );
        final quality = details.qualityOptions.firstWhere(
          (q) => q.qualityLabel == event.videoModel.qualityLabel,
          orElse: () => details.qualityOptions.first,
        );

        await _downloadService.startDownload(details, quality);
      })().timeout(const Duration(minutes: 5));

      emit(const DownloadInitial());
    } on TimeoutException {
      emit(
        const DownloadFailure(
          error:
              "Session timed out. Please check your connection and try again.",
        ),
      );
    } catch (e) {
      emit(DownloadFailure(error: "Retry failed: ${e.toString()}"));
    }
  }

  Future<void> _onCancelDownload(
    CancelDownloadEvent event,
    Emitter<DownloadState> emit,
  ) async {
    emit(const DownloadLoading());
    try {
      await _downloadService
          .cancelDownload(event.videoId)
          .timeout(const Duration(minutes: 5));
      emit(const DownloadInitial());
    } on TimeoutException {
      emit(
        const DownloadFailure(
          error: "Session timed out while canceling. Please try again.",
        ),
      );
    } catch (e) {
      emit(DownloadFailure(error: e.toString()));
    }
  }
}
