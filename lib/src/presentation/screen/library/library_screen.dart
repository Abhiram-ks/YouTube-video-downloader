import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:videodownload/core/common/custom_loading.dart';
import 'package:videodownload/core/common/custom_shadow.dart';
import 'package:videodownload/core/common/custom_snackbar.dart';
import 'package:videodownload/core/constants/app_constant.dart';
import 'package:videodownload/core/router/router.dart';
import 'package:videodownload/core/common/custom_network_builder.dart';
import 'package:videodownload/core/theme/app_palette.dart';
import 'package:videodownload/core/utils/fromat/format.dart';
import 'package:videodownload/src/data/local/model/downloaded_video_model.dart';
import 'package:videodownload/src/presentation/state/bloc/download_bloc/download_bloc.dart';
import 'package:videodownload/src/presentation/state/cubit/library_cubit/library_cubit/library_cubit.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.blue,
      appBar: AppBar(
        title: Text(
          "Downloads",
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
            }
          },
          builder: (context, downloadState) {
            return Stack(
              children: [
                RefreshIndicator(
                  onRefresh: () =>
                      context.read<LibraryCubit>().refreshLibrary(),
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
                              child: _buildEmptyState(context),
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
                              return _buildVideoCard(context, video);
                            },
                          ),
                        );
                      }

                      if (state is LibraryError) {
                        return SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: Center(child: Text(state.message)),
                          ),
                        );
                      }

                      return const SizedBox();
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
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppPalette.button,
        shape: const CircleBorder(),
        onPressed: () {
          _showHelpInfo(context);
        },
        child: const Icon(Icons.help_outline_sharp, color: AppPalette.white),
      ),
    );
  }

  void _showHelpInfo(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: AppPalette.trasprent,
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Material(
            color: AppPalette.trasprent,
            child: Stack(
              children: [
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.12,
                  right: 20.w,
                  child: Container(
                    width: 250.w,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppPalette.resinBlack,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildHelpItem(
                          icon: Icons.info_outline_rounded,
                          text: "Quick Help",
                          color:  AppPalette.orange,
                          context: context,
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(color: AppPalette.white.withValues(alpha: 0.8),fontWeight: .bold),
                        ),
                        Constant.height(12),
                        buildHelpItem(
                         icon: Icons.swipe_left_outlined,
                         text:  "Swipe left on a video to reveal options to play, retry the download, or delete the file.",
                        context:  context,
                         style:  Theme.of(context).textTheme.labelLarge!
                              .copyWith(color: AppPalette.white.withValues(alpha: 0.8),),
                        ),
                        Constant.height(6),
                        buildHelpItem(
                         icon:  Icons.download_done_rounded,
                          text:  "Play completed videos anytime, even without an internet connection.",
                          context:  context,
                         style:  Theme.of(context).textTheme.labelLarge!
                              .copyWith(color: AppPalette.white.withValues(alpha: 0.8),),
                        ),
                        Constant.height(6),
                        buildHelpItem(
                         icon:  Icons.refresh_rounded,
                         text:  "Failed downloads can be retried using the sync icon.",
                        context:  context,
                         style:  Theme.of(context).textTheme.labelLarge!
                              .copyWith(color: AppPalette.white.withValues(alpha: 0.8),),
                        ),
                      ],
                    ),
                  ),
                ),
                // Tiny triangle to make it look like a bubble
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.108,
                  right: 45.w,
                  child: Transform.rotate(
                    angle: 45 * 3.14159 / 180,
                    child: Container(
                      width: 20.w,
                      height: 20.w,
                      decoration: const BoxDecoration(
                        color: AppPalette.resinBlack,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.video_library_outlined,
            size: 64.sp,
            color: AppPalette.grey,
          ),
          Constant.height(8),
          Text(
            "No downloaded videos yet",
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppPalette.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoCard(BuildContext context, DownloadedVideoModel video) {
    final bool isDownloading = video.status == DownloadStatus.processing;

    late Color actionColor;
    late IconData actionIcon;
    late String actionLabel;
    late void Function(BuildContext) onActionPressed;

    switch (video.status) {
      case DownloadStatus.completed:
        actionColor = AppPalette.parisGreen;
        actionIcon = Icons.play_circle_outlined;
        actionLabel = 'Play';
        onActionPressed = (context) {
          context.pushNamed(
            AppRoutes.videoPlayer,
            extra: {
              'url': video.filePath,
              'title': video.title,
              'isLocal': true,
            },
          );
        };
        break;
      case DownloadStatus.processing:
        actionColor = AppPalette.blue;
        actionIcon = Icons.close_rounded;
        actionLabel = 'Cancel';
        onActionPressed = (context) {
          context.read<DownloadBloc>().add(
            CancelDownloadEvent(videoId: video.videoId),
          );
        };
        break;
      case DownloadStatus.retry:
      case DownloadStatus.canceled:
        actionColor = AppPalette.orange;
        actionIcon = Icons.refresh_rounded;
        actionLabel = 'Retry';
        onActionPressed = (context) {
          context.read<DownloadBloc>().add(
            RetryDownloadEvent(videoModel: video),
          );
        };
        break;
    }

    return Slidable(
      key: ValueKey(video.id),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: onActionPressed,
            backgroundColor: actionColor.withValues(alpha: 0.1),
            foregroundColor: actionColor,
            icon: actionIcon,
            label: actionLabel,
            borderRadius: BorderRadius.circular(12.r),
          ),
          SlidableAction(
            onPressed: (context) {
              _showDeleteDialog(context, video);
            },
            backgroundColor: AppPalette.red.shade100,
            foregroundColor: AppPalette.red,
            icon: Icons.delete_outline_rounded,
            label: 'Delete',
            borderRadius: BorderRadius.circular(12.r),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          if (video.status == DownloadStatus.completed) {
            context.pushNamed(
              AppRoutes.videoPlayer,
              extra: {
                'url': video.filePath,
                'title': video.title,
                'isLocal': true,
              },
            );
          }
        },
        borderRadius: BorderRadius.circular(12.r),
        child: Card(
          elevation: .3,
          margin: .zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Container(
            padding: EdgeInsets.all(8.w),

            decoration: customBoxDecoration(borderRadius: 12),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        customNetworkBuilder(
                          imageUrl: video.thumbnailUrl,
                          width: 100.w,
                          height: 79.h,
                          borderRadius: BorderRadius.circular(8.r),
                          boxfit: BoxFit.cover,
                          isCached: true,
                        ),
                        if (video.status == DownloadStatus.completed)
                          Positioned.fill(
                            child: Center(
                              child: Container(
                                padding: EdgeInsets.all(4.w),
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                  size: 20.sp,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    Constant.width(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            video.title,
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall?.copyWith(fontWeight: .bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Constant.height(4),
                          Text(
                            video.author,
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(color: AppPalette.grey),
                          ),
                          Constant.height(4),
                          _buildStatusBadge(video, context),
                        ],
                      ),
                    ),
                  ],
                ),
                if (isDownloading) ...[
                  SizedBox(height: 12.h),
                  LinearPercentIndicator(
                    lineHeight: 7.h,
                    percent: video.progress / 100,
                    center: Text(
                      "${video.progress}%",
                      style: TextStyle(
                        fontSize: 6.sp,
                        fontWeight: FontWeight.bold,
                        color: AppPalette.black,
                      ),
                    ),
                    backgroundColor: AppPalette.grey.withValues(alpha: 0.2),
                    progressColor: AppPalette.blue,
                    barRadius: Radius.circular(4.r),
                    animation: true,
                    animateFromLastPercent: true,
                    padding: EdgeInsets.zero,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(DownloadedVideoModel video, BuildContext context) {
    Color color;
    String text;
    IconData icon;

    switch (video.status) {
      case DownloadStatus.completed:
        color = Colors.green;
        text = "Completed";
        icon = Icons.check_circle_outline;
        break;
      case DownloadStatus.processing:
        color = AppPalette.blue;
        text = "Downloading...";
        icon = Icons.downloading_outlined;
        break;
      case DownloadStatus.retry:
        color = Colors.orange;
        text = "Failed - Swipe to Retry";
        icon = Icons.refresh_outlined;
        break;
      case DownloadStatus.canceled:
        color = Colors.red;
        text = "Canceled - Swipe to Retry";
        icon = Icons.cancel_outlined;
        break;
    }

    return Row(
      children: [
        Icon(icon, size: 14.sp, color: color),
        Constant.width(4),
        Expanded(
          child: Text(
            text,
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(color: color, fontWeight: .bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (video.sizeInBytes != null)
          Text(
            formatSize(video.sizeInBytes!),
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(color: AppPalette.grey),
          ),
      ],
    );
  }

  void _showDeleteDialog(BuildContext context, DownloadedVideoModel video) {
    // Capture the cubit before opening the dialog to avoid "deactivated widget" exceptions
    final cubit = context.read<LibraryCubit>();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppPalette.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.r),
        ),
        titlePadding: EdgeInsets.all(12.sp),
        contentPadding: EdgeInsets.all(16.sp),
        actionsPadding: EdgeInsets.all(16.sp),
        title: Text(
          "Delete Video?",
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: .bold),
        ),
        content: Text(
          "Are you sure you want to delete '${video.title}'?",
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppPalette.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text(
              "Cancel",
              style: TextStyle(color: AppPalette.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              cubit.deleteVideo(video);
              Navigator.pop(dialogContext);
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

Widget buildHelpItem({
  required IconData icon,
  required TextStyle style,
  required BuildContext context,
  Color color = AppPalette.grey,
  required String text,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, color: color, size: 16.sp),
      Constant.width(8),
      Expanded(child: Text(text, style: style)),
    ],
  );
}
