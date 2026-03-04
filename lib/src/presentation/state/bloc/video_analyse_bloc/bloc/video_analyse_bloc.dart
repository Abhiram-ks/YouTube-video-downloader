import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:videodownload/src/domain/entity/video_details.dart';
import 'package:videodownload/src/domain/usecase/video_usecase.dart';
part 'video_analyse_event.dart';
part 'video_analyse_state.dart';

class VideoAnalyseBloc extends Bloc<VideoAnalyseEvent, VideoAnalyseState> {
  final VideoUsecase _videoUsecase;
  VideoAnalyseBloc({required VideoUsecase videoUsecase}): _videoUsecase = videoUsecase, super(VideoAnalyseInitial()) {
    on<AnalyzeVideoLink>((event, emit) async {
        emit(VideoAnalyseLoading());
        try{
          final videoDetails = await _videoUsecase(event.url);
          emit(VideoAnalyseSuccess(videoDetails));
        }catch(e){
          emit(VideoAnalyseFailure(e.toString()));
        }
    });

    on<ResetAnalysis>((event, emit) {
       emit(VideoAnalyseInitial());
    });
  }
}
