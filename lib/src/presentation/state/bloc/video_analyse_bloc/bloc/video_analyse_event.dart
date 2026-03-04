part of 'video_analyse_bloc.dart';

@immutable
sealed class VideoAnalyseEvent extends Equatable {
  const VideoAnalyseEvent();

  @override
  List<Object?> get props => [];
}

final class AnalyzeVideoLink extends VideoAnalyseEvent {
  final String url;
  const AnalyzeVideoLink(this.url);

  @override
  List<Object?> get props => [url];
}

final class ResetAnalysis extends VideoAnalyseEvent {
  const ResetAnalysis();
}
