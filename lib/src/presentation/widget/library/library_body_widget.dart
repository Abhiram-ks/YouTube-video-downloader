import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:videodownload/core/common/custom_loading.dart';
import 'package:videodownload/core/common/custom_snackbar.dart';
import 'package:videodownload/core/constants/app_constant.dart';
import 'package:videodownload/core/theme/app_palette.dart';
import 'package:videodownload/src/presentation/state/bloc/download_bloc/download_bloc.dart';
import 'package:videodownload/src/presentation/state/cubit/library_cubit/library_cubit.dart';
import 'package:videodownload/src/presentation/widget/library/library_build_error_empty_state.dart';
import 'package:videodownload/src/presentation/widget/library/library_custom_card_widget.dart';

class LibraryScreenBodyWidget extends StatelessWidget {
  const LibraryScreenBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: BlocConsumer<DownloadBloc, DownloadState>(
          listener: (context, state) {
            if (state is DownloadFailure) {
              CustomSnackBar.show(
                context,
                message: state.error,
                backgroundColor: AppPalette.brickRed,
                textColor: AppPalette.white,
              );
            } else if (state is SaveToGallerySuccess) {
              CustomSnackBar.show(
                context,
                message: "Video saved to gallery successfully!",
                backgroundColor: AppPalette.parisGreen,
                textColor: AppPalette.white,
              );
            }
          },
          builder: (context, downloadState) {
            return Stack(
              children: [
                RefreshIndicator(
                  onRefresh: () => context.read<LibraryCubit>().refreshLibrary(),
                  color: AppPalette.button,
                  backgroundColor: AppPalette.white,
                  child: BlocBuilder<LibraryCubit, LibraryState>(
                    builder: (context, state) {
                      if (state is LibraryLoading) {
                        return customLoading(
                          context: context,
                          title: "Loading your library...",
                        );
                      }
                      if (state is LibraryLoaded) {
                        final videos = state.videos;
                        if (videos.isEmpty) {
                          return SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: buildEmptyErrorState(
                                context: context,
                                title: "Awaiting your first video",
                                subTitle:
                                    "Your favorite moments will appear here once downloaded.",
                              ),
                            ),
                          );
                        }
                        return Padding(
                          padding: EdgeInsets.only(top: 10.0.h),
                          child: ListView.separated(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 20.h,
                            ),
                            itemCount: videos.length,
                            separatorBuilder: (context, index) =>
                                Constant.height(10),
                            itemBuilder: (context, index) {
                              final video = videos[index];
                              return buildVideoCard(context, video);
                            },
                          ),
                        );
                      }

                      if (state is LibraryError) {
                        return SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: buildEmptyErrorState(
                              context: context,
                              title:
                                  "We couldn't process your request right now.",
                              subTitle: state.message.toString(),
                            ),
                          ),
                        );
                      }

                      return SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: buildEmptyErrorState(
                            context: context,
                            title: "Unable to process request",
                            subTitle:"An unexpected error occurred during processing. Please try again.",
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (downloadState is DownloadLoading) ...[
                  customLoading(
                    context: context,
                    title: "Processing your request...",
                  ),
                ],
              ],
            );
          },
        ),
      );
  }
}