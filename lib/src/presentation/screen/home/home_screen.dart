import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:videodownload/core/debouncer/debouncer.dart';
import 'package:videodownload/core/theme/app_palette.dart';
import 'package:videodownload/src/presentation/state/bloc/video_analysis_bloc/video_analysis_bloc.dart';
import 'package:videodownload/src/presentation/state/bloc/video_analysis_bloc/video_analysis_state.dart';
import 'package:videodownload/src/presentation/state/cubit/progresser_cubit/progresser_cubit.dart';
import 'package:videodownload/src/presentation/widget/home/home_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _urlController = TextEditingController();
  final Debouncer _debouncer = Debouncer(milliseconds: 500);

  @override
  void dispose() {
    _urlController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<VideoAnalysisBloc, VideoAnalysisState>(
        listener: (context, state) {
          if (state is VideoAnalysisLoading) {
            context.read<ProgresserCubit>().startLoading(
              message: "Processing...",
            );
          } else if (state is VideoAnalysisSuccess) {
            context.read<ProgresserCubit>().stopLoading();
            showVideoDetails(context: context,state: state);
          } else if (state is VideoAnalysisFailure) {
            context.read<ProgresserCubit>().stopLoading();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: AppPalette.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Cinematic Stream",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 32.sp,
                      ),
                    ),
                    Text(
                      "Own Your Content. Download your media, your way, in breathtaking quality.",
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: AppPalette.grey),
                      textAlign: TextAlign.center,
                    ),
                    Constant.height(24),
                    Card(
                      margin: EdgeInsets.zero,
                      elevation: 0.3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Container(
                        decoration: customBoxDecoration(borderRadius: 12),
                        child: TextFormFieldWidget(
                          controller: _urlController,
                          borderRadius: 12,
                          hintText: "Paste video link here..",
                          prefixWidget: Padding(
                            padding: EdgeInsets.only(left: 6.w, right: 8.w),
                            child: Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                color: AppPalette.blue,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Icon(
                                Icons.link,
                                color: AppPalette.white,
                                size: 18.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Constant.height(16),
                    Builder(
                      builder: (context) {
                        return CustomButton(
                          text: "Analyze Link",
                          loadingText: "Processing",
                          onPressed: () {
                            _debouncer.run(() {
                              context.read<VideoAnalysisBloc>().add(
                                AnalyzeVideoLink(_urlController.text),
                              );
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            // Circular progress stack top
            BlocBuilder<VideoAnalysisBloc, VideoAnalysisState>(
              builder: (context, state) {
                if (state is VideoAnalysisLoading) {
                  return Container(
                    color: AppPalette.black.withValues(alpha: 0.2),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 20.h,
                        ),
                        decoration: customBoxDecoration(borderRadius: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 24.w,
                              width: 24.w,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppPalette.blue,
                              ),
                            ),
                            Constant.height(16),
                            Text(
                              "Processing your request...",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              "Please wait a moment",
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }


  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration.inHours > 0) {
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    }
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  String _formatSize(int bytes) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB"];
    var i = (math.log(bytes) / math.log(1024)).floor();
    return "${(bytes / math.pow(1024, i)).toStringAsFixed(1)} ${suffixes[i]}";
  }
}
