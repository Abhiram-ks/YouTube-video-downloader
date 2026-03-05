part of 'download_bloc.dart';

abstract class DownloadState extends Equatable {
  const DownloadState();

  @override
  List<Object?> get props => [];
}

class DownloadInitial extends DownloadState {
  const DownloadInitial();
}

class DownloadLoading extends DownloadState {
  const DownloadLoading();
}

class DownloadInProgress extends DownloadState {
  final String videoId;
  final int progress;

  const DownloadInProgress({required this.videoId, required this.progress});

  @override
  List<Object?> get props => [videoId, progress];
}

class DownloadSuccess extends DownloadState {
  final String videoId;

  const DownloadSuccess({required this.videoId});

  @override
  List<Object?> get props => [videoId];
}

class DownloadFailure extends DownloadState {
  final String error;

  const DownloadFailure({required this.error});

  @override
  List<Object?> get props => [error];
}


class SaveToGallerySuccess extends DownloadState {}
