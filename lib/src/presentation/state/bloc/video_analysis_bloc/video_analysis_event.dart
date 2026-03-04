import 'package:flutter/foundation.dart';

@immutable
abstract class VideoAnalysisEvent {}

class AnalyzeVideoLink extends VideoAnalysisEvent {
  final String url;
  AnalyzeVideoLink(this.url);
}

class ResetAnalysis extends VideoAnalysisEvent {}
