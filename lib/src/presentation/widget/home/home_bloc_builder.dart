import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:videodownload/core/common/custom_button.dart';
import 'package:videodownload/core/common/custom_image_show.dart';
import 'package:videodownload/core/common/custom_inputbox.dart';
import 'package:videodownload/core/common/custom_loading.dart';
import 'package:videodownload/core/common/custom_shadow.dart';
import 'package:videodownload/core/common/custom_snackbar.dart';
import 'package:videodownload/core/constants/app_constant.dart';
import 'package:videodownload/core/debouncer/debouncer.dart';
import 'package:videodownload/core/theme/app_palette.dart';
import 'package:videodownload/core/utils/validation/validation_helper.dart';
import 'package:videodownload/src/presentation/screen/library/library_screen.dart';
import 'package:videodownload/src/presentation/state/bloc/video_analyse_bloc/video_analyse_bloc.dart';
import 'package:videodownload/src/presentation/widget/home/home_state_handle.dart';

class HomeBlocBuilderWidget extends StatelessWidget {
  const HomeBlocBuilderWidget({
    super.key,
    required TextEditingController urlController,
    required Debouncer debouncer,
  }) : _urlController = urlController,
       _debouncer = debouncer;

  final TextEditingController _urlController;
  final Debouncer _debouncer;

  @override
  Widget build(BuildContext context) {
    return BlocListener<VideoAnalyseBloc, VideoAnalyseState>(
      listener: (context, state) {
        homeStateHanlde(
          context: context,
          state: state,
          urlController: _urlController,
        );
      },
      child: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
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
                            buildHelpItem(
                              icon: Icons.info_outline_rounded,
                              text: "YouTube Media Acquisition Guide",
                              color: AppPalette.orange,
                              context: context,
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(
                                    color: AppPalette.white.withValues(
                                      alpha: 0.8,
                                    ),
                                    fontWeight: .bold,
                                  ),
                            ),
                            Constant.height(12),
                            buildHelpItem(
                              icon: Icons.link_rounded,
                              text:
                                  "Paste a valid YouTube video link into the input field.",
                              context: context,
                              color: AppPalette.white2,
                              style: Theme.of(context).textTheme.labelLarge!
                                  .copyWith(
                                    color: AppPalette.white.withValues(
                                      alpha: 0.8,
                                    ),
                                  ),
                            ),
                            Constant.height(4),
                            buildHelpItem(
                              icon: Icons.analytics_outlined,
                              text:
                                  "Tap 'Analyze Link' to fetch available video qualities.",
                              color: AppPalette.white2,
                              context: context,
                              style: Theme.of(context).textTheme.labelLarge!
                                  .copyWith(
                                    color: AppPalette.white.withValues(
                                      alpha: 0.8,
                                    ),
                                  ),
                            ),
                            Constant.height(4),
                            buildHelpItem(
                              icon: Icons.file_download_outlined,
                              text:
                                  "Select your preferred quality and start downloading instantly.",
                              color: AppPalette.white2,
                              context: context,
                              style: Theme.of(context).textTheme.labelLarge!
                                  .copyWith(
                                    color: AppPalette.white.withValues(
                                      alpha: 0.8,
                                    ),
                                  ),
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
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppPalette.grey),
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
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
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
                                          backgroundColor: AppPalette.brickRed,
                                        );
                                        return;
                                      }
                                      context.read<VideoAnalyseBloc>().add(
                                        AnalyzeVideoLink(_urlController.text),
                                      );
                                    });
                                    FocusScope.of(context).unfocus();
                                  },
                                );
                              },
                            ),
                            Constant.height(30),
                            column(context: context),
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
    );
  }
}
