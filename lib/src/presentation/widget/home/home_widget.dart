
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:videodownload/core/common/custom_network_builder.dart';
import 'package:videodownload/core/common/custom_shadow.dart';
import 'package:videodownload/core/theme/app_palette.dart';
import 'package:videodownload/src/presentation/state/bloc/video_analysis_bloc/video_analysis_state.dart';

void showVideoDetails({
required BuildContext context,
required VideoAnalysisSuccess state
}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return SafeArea(
          bottom: false,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.9,
            ),
            child: Container(
              decoration: customBoxDecoration(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Drag Handle
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    width: double.infinity,
                    child: Center(
                      child: Container(
                        width: 40.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: AppPalette.grey.withValues(alpha: .2),
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),
                  ),
                  // Scrollable Content
                  Flexible(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 32.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16.r),
                                child: customNetworkBuilder(
                                  imageUrl: state.videoDetails.thumbnailUrl,
                                  aspectRatio: 16 / 9,
                                  boxfit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                              Positioned(
                                bottom: 12.h,
                                right: 12.w,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 4.h,
                                  ),
                                  decoration: customBoxDecoration(
                                    color: AppPalette.black,
                                    borderRadius: 4,
                                  ),
                                  child: Text(
                                    formatDuration(
                                      state.videoDetails.duration,
                                    ),
                                    style: TextStyle(
                                      color: AppPalette.white,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Constant.height(16),
                          Text(
                            state.videoDetails.title,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Constant.height(8),
                          Row(
                            children: [
                              ClipOval(
                                child: Container(
                                  height: 30.w,
                                  width: 30.w,
                                  decoration: customBoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: customNetworkBuilder(
                                    imageUrl: state.videoDetails.logo,
                                  ),
                                ),
                              ),
                              Constant.width(8),
                              Text(
                                state.videoDetails.author,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: AppPalette.grey),
                              ),
                            ],
                          ),
                          Constant.height(24),
                          Text(
                            "Select Download Quality",
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          Constant.height(12),
                          Wrap(
                            spacing: 12.w,
                            runSpacing: 12.h,
                            children: state.videoDetails.qualityOptions.map((
                              option,
                            ) {
                              return InkWell(
                                borderRadius: BorderRadius.circular(12.r),
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Preparing ${option.qualityLabel} for download...",
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                  Navigator.pop(context);
                                },
                                child: Card(
                                  margin: EdgeInsets.zero,
                                  elevation: 0.3,
                                  color: AppPalette.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 12.h,
                                    ),
                                    decoration: customBoxDecoration(
                                      borderRadius: 12,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.file_download_outlined,
                                          color: AppPalette.blue,
                                          size: 24.sp,
                                        ),
                                        Constant.height(6),
                                        Text(
                                          option.qualityLabel,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: AppPalette.blue,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        if (option.sizeInBytes != null)
                                          Text(
                                            _formatSize(option.sizeInBytes!),
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge
                                                ?.copyWith(
                                                  color: AppPalette.grey,
                                                  fontSize: 10.sp,
                                                ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }