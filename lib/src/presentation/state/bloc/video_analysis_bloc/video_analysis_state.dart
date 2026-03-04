import 'package:bizforz/src/domain/entity/video_details.dart';
import 'package:flutter/foundation.dart';
import 'package:videodownload/src/domain/entity/video_details.dart';

@immutable
abstract class VideoAnalysisState {}

class VideoAnalysisInitial extends VideoAnalysisState {}

class VideoAnalysisLoading extends VideoAnalysisState {}

class VideoAnalysisSuccess extends VideoAnalysisState {
  final VideoDetails videoDetails;
  VideoAnalysisSuccess(this.videoDetails);
}

class VideoAnalysisFailure extends VideoAnalysisState {
  final String error;
  VideoAnalysisFailure(this.error);
}
