import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:videodownload/core/theme/app_palette.dart';
import 'package:videodownload/src/data/local/model/downloaded_video_model.dart';
import 'package:videodownload/src/presentation/state/cubit/library_cubit/library_cubit.dart';

void showDeleteDialog(BuildContext context, DownloadedVideoModel video) {
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