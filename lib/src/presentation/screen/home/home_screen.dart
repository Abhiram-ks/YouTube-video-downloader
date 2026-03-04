import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:videodownload/core/common/custom_button.dart';
import 'package:videodownload/core/common/custom_inputbox.dart';
import 'package:videodownload/core/common/custom_loading.dart';
import 'package:videodownload/core/common/custom_shadow.dart';
import 'package:videodownload/core/common/custom_snackbar.dart';
import 'package:videodownload/core/debouncer/debouncer.dart';
import 'package:videodownload/core/theme/app_palette.dart';
import 'package:videodownload/src/presentation/screen/library/library_screen.dart';
import 'package:videodownload/core/utils/validation/validation_helper.dart';
import 'package:videodownload/src/presentation/state/bloc/video_analyse_bloc/video_analyse_bloc.dart';
import 'package:videodownload/src/presentation/state/cubit/progresser_cubit/progresser_cubit.dart';
import 'package:videodownload/src/presentation/widget/home/home_widget.dart';

import '../../../../core/assets/assets.dart';
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

  Widget buildHelpItem(
    IconData icon,
    String text,
    BuildContext context, {
    Color? color,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color ?? AppPalette.orange, size: 18.sp),
        Constant.width(8),
        Expanded(
          child: Text(
            text,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: color ?? AppPalette.white),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppPalette.blue,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            "YouTube Save",
            style: TextStyle(
              color: AppPalette.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.only(top: 12.h),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: AppPalette.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r),
              topRight: Radius.circular(30.r),
            ),
          ),
          child: BlocListener<VideoAnalyseBloc, VideoAnalyseState>(
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
                CustomSnackBar.show(
                  context,
                  message: state.error,
                  backgroundColor: AppPalette.brickRed,
                  textColor: AppPalette.white,
                );
              }
            },
            child: Stack(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: AppPalette.blue,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30.r),
                                  bottomRight: Radius.circular(30.r),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.info_outline_rounded,
                                        color: AppPalette.orange,
                                        size: 20.sp,
                                      ),
                                      Constant.width(4),
                                      Text(
                                        "YouTube Media Acquisition Guide",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: AppPalette.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ],
                                  ),
                                  Constant.height(12),
                                  buildHelpItem(
                                    Icons.link_rounded,
                                    "Paste any YouTube video link into the input field below.",
                                    context,
                                    color: AppPalette.white2,
                                  ),
                                  Constant.height(4),
                                  buildHelpItem(
                                    Icons.analytics_outlined,
                                    "Tap 'Analyze Link' to fetch available video qualities.",
                                    context,
                                    color: AppPalette.white2,
                                  ),
                                  Constant.height(4),
                                  buildHelpItem(
                                    Icons.file_download_outlined,
                                    "Select your preferred quality and start downloading instantly.",
                                    context,
                                    color: AppPalette.white2,
                                  ),
                                ],
                              ),
                            ),
                            Constant.height(24),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 20.h,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "Own Your Content. Download your media, your way, in breathtaking quality.",
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(color: AppPalette.grey),
                                    textAlign: TextAlign.center,
                                  ),
                                  Constant.height(8),
                                  Card(
                                    margin: EdgeInsets.zero,
                                    elevation: 0.3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Container(
                                      decoration: customBoxDecoration(
                                        borderRadius: 12,
                                      ),
                                      child: TextFormFieldWidget(
                                        controller: _urlController,
                                        borderRadius: 12,
                                        hintText: "Paste video link here..",
                                        prefixWidget: Padding(
                                          padding: EdgeInsets.only(
                                            left: 6.w,
                                            right: 8.w,
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.all(10.w),
                                            decoration: BoxDecoration(
                                              color: AppPalette.blue,
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
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
                                            final error =
                                                ValidationHelper.uriValidation(
                                                  context: context,
                                                  url: _urlController.text,
                                                );

                                            if (error != null) {
                                              CustomSnackBar.show(
                                                context,
                                                message: error,
                                                backgroundColor:
                                                    AppPalette.brickRed,
                                              );
                                              return;
                                            }

                                            context
                                                .read<VideoAnalyseBloc>()
                                                .add(
                                                  AnalyzeVideoLink(
                                                    _urlController.text,
                                                  ),
                                                );
                                          });
                                          FocusScope.of(context).unfocus();
                                        },
                                      );
                                    },
                                  ),
                                  Constant.height(30),
                                  Image.asset(
                                    applogo,
                                    height: 100.h,
                                    width: 100.w,
                                  ),
                                  Constant.height(6),
                                  Text(
                                    "iSARGO : Cinematic Stream",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "© 2026 Flutter Development.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(color: AppPalette.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
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
        ),
      ),
    );
  }
}
