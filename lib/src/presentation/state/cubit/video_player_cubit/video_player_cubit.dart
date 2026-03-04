import 'package:bloc/bloc.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:videodownload/core/theme/app_palette.dart';
import 'video_player_state.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  VideoPlayerCubit() : super(const VideoPlayerInitial());

  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  Future<void> initializePlayer(String url) async {
    emit(const VideoPlayerLoading());

    try {
      _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url));

      await _videoPlayerController!.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: true,
        looping: false,
        aspectRatio: _videoPlayerController!.value.aspectRatio,
        allowFullScreen: true,
        allowPlaybackSpeedChanging: true,
        showControls: true,
        showSubtitles: true,

        placeholder: Container(
          color: AppPalette.black,
          child: const Center(
            child: CircularProgressIndicator(color: AppPalette.blue),
          ),
        ),
        deviceOrientationsAfterFullScreen: [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ],
      );

      emit(
        VideoPlayerLoaded(
          chewieController: _chewieController!,
          videoPlayerController: _videoPlayerController!,
        ),
      );
    } catch (e) {
      emit(VideoPlayerError("Could not load video: ${e.toString()}"));
    }
  }

  @override
  Future<void> close() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    return super.close();
  }
}
