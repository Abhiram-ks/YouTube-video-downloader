import 'package:chewie/chewie.dart';
import 'package:equatable/equatable.dart';
import 'package:video_player/video_player.dart';

sealed class VideoPlayerState extends Equatable {
  const VideoPlayerState();

  @override
  List<Object?> get props => [];
}

final class VideoPlayerInitial extends VideoPlayerState {
  const VideoPlayerInitial();
}

final class VideoPlayerLoading extends VideoPlayerState {
  const VideoPlayerLoading();
}

final class VideoPlayerLoaded extends VideoPlayerState {
  final ChewieController chewieController;
  final VideoPlayerController videoPlayerController;

  const VideoPlayerLoaded({
    required this.chewieController,
    required this.videoPlayerController,
  });

  @override
  List<Object?> get props => [chewieController, videoPlayerController];
}

final class VideoPlayerError extends VideoPlayerState {
  final String message;
  const VideoPlayerError(this.message);

  @override
  List<Object?> get props => [message];
}
