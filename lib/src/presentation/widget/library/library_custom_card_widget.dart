import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:videodownload/core/common/custom_network_builder.dart';
import 'package:videodownload/core/common/custom_shadow.dart';
import 'package:videodownload/core/constants/app_constant.dart';
import 'package:videodownload/core/router/router.dart';
import 'package:videodownload/core/theme/app_palette.dart';
import 'package:videodownload/core/utils/fromat/format.dart';
import 'package:videodownload/src/data/local/model/downloaded_video_model.dart';
import 'package:videodownload/src/presentation/state/bloc/download_bloc/download_bloc.dart';
import 'package:videodownload/src/presentation/widget/library/library_delete_dialog_box_widget.dart';

Widget buildVideoCard(BuildContext context, DownloadedVideoModel video) {
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
              showDeleteDialog(context, video);
            },
            backgroundColor: AppPalette.red.shade100,
            foregroundColor: AppPalette.red,
            icon: Icons.delete_outline_rounded,
            label: 'Delete',
            borderRadius: BorderRadius.circular(12.r),
          ),
          if (video.status == DownloadStatus.completed) ...[
            SlidableAction(
              onPressed: (context) {
                context.read<DownloadBloc>().add(
                  SaveToGalleryEvent(videoId: video.videoId),
                );
              },
              backgroundColor: AppPalette.blue.withValues(alpha: 0.1),
              foregroundColor: AppPalette.blue,
              icon: Icons.save_alt_outlined,
              label: 'Save',
              borderRadius: BorderRadius.circular(12.r),
            ),
          ],
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
            formatSize(video.sizeInBytes ?? 0),
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(color: AppPalette.grey),
          ),
      ],
    );
  }
