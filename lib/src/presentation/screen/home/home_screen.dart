import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:videodownload/core/common/custom_button.dart';
import 'package:videodownload/core/common/custom_inputbox.dart';
import 'package:videodownload/core/common/custom_loading.dart';
import 'package:videodownload/core/common/custom_shadow.dart';
import 'package:videodownload/core/debouncer/debouncer.dart';
import 'package:videodownload/core/theme/app_palette.dart';
import 'package:videodownload/src/presentation/state/bloc/video_analyse_bloc/bloc/video_analyse_bloc.dart';
import 'package:videodownload/src/presentation/state/cubit/progresser_cubit/progresser_cubit.dart';
import 'package:videodownload/src/presentation/widget/home/home_widget.dart';

import '../../../../core/constants/app_constant.dart';

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
      body: BlocListener<VideoAnalyseBloc, VideoAnalyseState>(
        listener: (context, state) {
          if (state is VideoAnalyseLoading) {
            context.read<ProgresserCubit>().startLoading(
              message: "Processing...",
            );
          } else if (state is VideoAnalyseSuccess) {
            context.read<ProgresserCubit>().stopLoading();
            showVideoDetails(context: context, video: state.videoDetails);
          } else if (state is VideoAnalyseFailure) {
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
                              context.read<VideoAnalyseBloc>().add(
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
            BlocBuilder<VideoAnalyseBloc, VideoAnalyseState>(
              builder: (context, state) {
                if (state is VideoAnalyseLoading) {
                  return customLoading(
                    context: context,
                    title: "Processing your request...",
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
}
