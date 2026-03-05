import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:videodownload/src/data/local/model/downloaded_video_model.dart';
import 'package:videodownload/src/domain/entity/video_details.dart';
import 'package:videodownload/src/domain/usecase/download_usecase.dart';
import 'package:videodownload/src/domain/usecase/video_usecase.dart';

part 'download_event.dart';
part 'download_state.dart';

class DownloadBloc extends Bloc<DownloadEvent, DownloadState> {
  final DownloadUseCase _downloadUseCase;
  final VideoUsecase _videoUseCase;

  DownloadBloc({
    required DownloadUseCase downloadUseCase,
    required VideoUsecase videoUseCase,
  }) : _downloadUseCase = downloadUseCase,
       _videoUseCase = videoUseCase,
       super(DownloadInitial()) {
    on<StartDownloadEvent>(_onStartDownload);
    on<RetryDownloadEvent>(_onRetryDownload);
    on<CancelDownloadEvent>(_onCancelDownload);
    on<SaveToGalleryEvent>(_onSaveToGallery);
  }

  Future<void> _onStartDownload(
    StartDownloadEvent event,
    Emitter<DownloadState> emit,
  ) async {
    try {
      await _downloadUseCase.startDownload(event.video, event.quality);
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
        final details = await _videoUseCase.call(
          "https://www.youtube.com/watch?v=${event.videoModel.videoId}",
        );
        final quality = details.qualityOptions.firstWhere(
          (q) => q.qualityLabel == event.videoModel.qualityLabel,
          orElse: () => details.qualityOptions.first,
        );

        await _downloadUseCase.startDownload(details, quality);
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
      await _downloadUseCase
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

  Future<void> _onSaveToGallery(
    SaveToGalleryEvent event,
    Emitter<DownloadState> emit,
  ) async {
    emit(const DownloadLoading());
    try {
      await _downloadUseCase.saveToGallery(event.videoId);
      emit(SaveToGallerySuccess());
    } catch (e) {
      log(e.toString());
      emit(DownloadFailure(error: e.toString()));
    }
  }
}
