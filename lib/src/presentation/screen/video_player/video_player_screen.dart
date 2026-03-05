import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:videodownload/core/common/custom_loading.dart';
import 'package:videodownload/core/di/di.dart';
import 'package:videodownload/core/theme/app_palette.dart';
import 'package:videodownload/src/presentation/state/cubit/video_player_cubit/video_player_cubit.dart';
import 'package:videodownload/src/presentation/state/cubit/video_player_cubit/video_player_state.dart';

class VideoPlayerScreen extends StatelessWidget {
  final String url;
  final String title;
  final bool isLocal;

  const VideoPlayerScreen({
    super.key,
    required this.url,
    required this.title,
    this.isLocal = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<VideoPlayerCubit>()..initializePlayer(url, isLocal: isLocal),
      child: Scaffold(
        backgroundColor: AppPalette.black,
        appBar: AppBar(
          backgroundColor: AppPalette.trasprent,
          elevation: 0,
          title: Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: AppPalette.white),
          ),
          leading: Padding(
            padding: EdgeInsets.all(12.w),
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                decoration: const BoxDecoration(
                  color: AppPalette.button,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_back,
                    color: AppPalette.white,
                    size: 16.sp,
                  ),
                ),
              ),
            ),
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
                    title: isLocal
                        ? "Decrypting video..."
                        : "Preparing preview...",
                  );
                } else if (state is VideoPlayerLoaded) {
                  return AspectRatio(
                    aspectRatio: state.videoPlayerController.value.aspectRatio,
                    child: Chewie(controller: state.chewieController),
                  );
                } else if (state is VideoPlayerError) {
                  return Padding(
                    padding: EdgeInsets.all(20.0.sp),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 48,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: AppPalette.white),
                        ),
                      ],
                    ),
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
