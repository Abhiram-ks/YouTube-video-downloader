import 'package:bizforz/src/domain/repo/video_repo.dart';
import 'package:bizforz/src/presentation/state/bloc/video_analysis_bloc/video_analysis_event.dart';
import 'package:bizforz/src/presentation/state/bloc/video_analysis_bloc/video_analysis_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoAnalysisBloc extends Bloc<VideoAnalysisEvent, VideoAnalysisState> {
  final VideoRepository videoRepository;

  VideoAnalysisBloc({required this.videoRepository})
    : super(VideoAnalysisInitial()) {
    on<AnalyzeVideoLink>((event, emit) async {
      if (event.url.isEmpty) {
        emit(VideoAnalysisFailure("Please enter a video link"));
        return;
      }

      emit(VideoAnalysisLoading());
      try {
        final videoDetails = await videoRepository.getVideoDetails(event.url);
        emit(VideoAnalysisSuccess(videoDetails));
      } catch (e) {
        emit(VideoAnalysisFailure(e.toString()));
      }
    });

    on<ResetAnalysis>((event, emit) {
      emit(VideoAnalysisInitial());
    });
  }
}
