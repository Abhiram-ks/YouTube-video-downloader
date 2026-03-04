import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:videodownload/core/common/custom_shadow.dart';
import 'package:videodownload/core/constants/app_constant.dart';
import 'package:videodownload/core/theme/app_palette.dart';

Widget customLoading({required BuildContext context, required String title}) {
  return Container(
    color: AppPalette.black.withValues(alpha: 0.2),
    child: Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        decoration: customBoxDecoration(borderRadius: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 24.w,
              width: 24.w,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppPalette.blue,
              ),
            ),
            Constant.height(16),
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
            Text(
              "Please wait a moment",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
      ),
    ),
  );
}
