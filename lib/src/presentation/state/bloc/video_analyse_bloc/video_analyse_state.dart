part of 'video_analyse_bloc.dart';

@immutable
sealed class VideoAnalyseState extends Equatable {
  const VideoAnalyseState();

  @override
  List<Object?> get props => [];
}

final class VideoAnalyseInitial extends VideoAnalyseState {
  const VideoAnalyseInitial();
}

final class VideoAnalyseLoading extends VideoAnalyseState {
  const VideoAnalyseLoading();
}

final class VideoAnalyseSuccess extends VideoAnalyseState {
  final VideoDetails videoDetails;
  const VideoAnalyseSuccess(this.videoDetails);

  @override
  List<Object?> get props => [videoDetails];
}

final class VideoAnalyseFailure extends VideoAnalyseState {
  final String error;
  const VideoAnalyseFailure(this.error);

  @override
  List<Object?> get props => [error];
}
