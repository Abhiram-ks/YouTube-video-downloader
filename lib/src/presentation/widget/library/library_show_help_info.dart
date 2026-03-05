  import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:videodownload/core/common/custom_helper_widget.dart';
import 'package:videodownload/core/constants/app_constant.dart';
import 'package:videodownload/core/theme/app_palette.dart';

void showHelpInfo(BuildContext context) {
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
                          color: AppPalette.orange,
                          context: context,
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                color: AppPalette.white.withValues(alpha: 0.8),
                                fontWeight: .bold,
                              ),
                        ),
                        Constant.height(12),
                        buildHelpItem(
                          icon: Icons.swipe_left_outlined,
                          text:
                              "Swipe left on a video to reveal options to play, retry the download, or delete the file.",
                          context: context,
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(
                                color: AppPalette.white.withValues(alpha: 0.8),
                              ),
                        ),
                        Constant.height(6),
                        buildHelpItem(
                          icon: Icons.download_done_rounded,
                          text:
                              "Play completed videos anytime, even without an internet connection.",
                          context: context,
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(
                                color: AppPalette.white.withValues(alpha: 0.8),
                              ),
                        ),
                        Constant.height(6),
                        buildHelpItem(
                          icon: Icons.refresh_rounded,
                          text:
                              "Failed downloads can be retried using the sync icon.",
                          context: context,
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(
                                color: AppPalette.white.withValues(alpha: 0.8),
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
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