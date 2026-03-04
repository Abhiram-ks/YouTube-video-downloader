import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:videodownload/core/common/custom_network_builder.dart';
import 'package:videodownload/core/common/custom_shadow.dart';
import 'package:videodownload/core/constants/app_constant.dart';
import 'package:videodownload/core/router/router.dart';
import 'package:videodownload/core/theme/app_palette.dart';
import 'package:videodownload/core/utils/fromat/format.dart';
import 'package:videodownload/src/domain/entity/video_details.dart';
import 'package:videodownload/src/presentation/state/bloc/download_bloc/download_bloc.dart';
import 'package:videodownload/src/presentation/state/cubit/navi_cubit/nav_cubit.dart';

void showVideoDetails({
  required BuildContext context,
  required VideoDetails video,
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
                Flexible(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 32.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            context.push(
                              AppRoutes.videoPlayer,
                              extra: {
                                'url': video.qualityOptions.first.url,
                                'title': video.title,
                              },
                            );
                          },
                          child: Stack(
                            children: [
                              customNetworkBuilder(
                                imageUrl: video.thumbnailUrl,
                                aspectRatio: 16 / 9,
                                boxfit: BoxFit.cover,
                                width: double.infinity,
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              Positioned.fill(
                                child: Center(
                                  child: Container(
                                    padding: EdgeInsets.all(8.w),
                                    decoration: BoxDecoration(
                                      color: AppPalette.black.withValues(
                                        alpha: 0.5,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.play_arrow_rounded,
                                      color: AppPalette.white,
                                      size: 32.sp,
                                    ),
                                  ),
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
                                    formatDuration(video.duration),
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
                        ),
                        Constant.height(16),
                        Text(
                          video.title,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Constant.height(8),
                        Row(
                          children: [
                            customNetworkBuilder(
                              imageUrl: video.logo,
                              width: 30.w,
                              height: 30.w,
                              decoration: customBoxDecoration(
                                shape: BoxShape.circle,
                              ),
                            ),
                            Constant.width(8),
                            Text(
                              video.author,
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
                          children: video.qualityOptions.map((option) {
                            return InkWell(
                              borderRadius: BorderRadius.circular(12.r),
                              onTap: () {
                                context.read<DownloadBloc>().add(
                                  StartDownloadEvent(
                                    video: video,
                                    quality: option,
                                  ),
                                );
                                context.read<ButtomNavCubit>().selectItem(
                                  NavItem.library,
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
                                          formatSize(option.sizeInBytes!),
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
