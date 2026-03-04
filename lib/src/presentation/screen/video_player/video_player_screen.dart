import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videodownload/core/common/custom_loading.dart';
import 'package:videodownload/core/di/di.dart';
import 'package:videodownload/core/theme/app_palette.dart';
import 'package:videodownload/src/presentation/state/cubit/video_player_cubit/video_player_cubit.dart';
import 'package:videodownload/src/presentation/state/cubit/video_player_cubit/video_player_state.dart';

class VideoPlayerScreen extends StatelessWidget {
  final String url;
  final String title;

  const VideoPlayerScreen({super.key, required this.url, required this.title});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<VideoPlayerCubit>()..initializePlayer(url),
      child: Scaffold(
        backgroundColor: AppPalette.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppPalette.white,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppPalette.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
              builder: (context, state) {
                if (state is VideoPlayerLoading ||
                    state is VideoPlayerInitial) {
                  return customLoading(
                    context: context,
                    title: "Preparing preview..."
                  );
                } else if (state is VideoPlayerLoaded) {
                  return AspectRatio(
                    aspectRatio: state.videoPlayerController.value.aspectRatio,
                    child: Chewie(controller: state.chewieController),
                  );
                } else if (state is VideoPlayerError) {
                  return Text(
                    state.message,
                    style: const TextStyle(color: AppPalette.white),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
