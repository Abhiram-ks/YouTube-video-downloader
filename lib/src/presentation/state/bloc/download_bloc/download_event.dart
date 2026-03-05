part of 'download_bloc.dart';

abstract class DownloadEvent extends Equatable {
  const DownloadEvent();

  @override
  List<Object?> get props => [];
}

class StartDownloadEvent extends DownloadEvent {
  final VideoDetails video;
  final VideoQualityOption quality;

  const StartDownloadEvent({required this.video, required this.quality});

  @override
  List<Object?> get props => [video, quality];
}

class RetryDownloadEvent extends DownloadEvent {
  final DownloadedVideoModel videoModel;

  const RetryDownloadEvent({required this.videoModel});

  @override
  List<Object?> get props => [videoModel];
}

class CancelDownloadEvent extends DownloadEvent {
  final String videoId;

  const CancelDownloadEvent({required this.videoId});

  @override
  List<Object?> get props => [videoId];
}

final class SaveToGalleryEvent extends DownloadEvent {
  final String videoId;

  const SaveToGalleryEvent({required this.videoId});

  @override
  List<Object?> get props => [videoId];
}