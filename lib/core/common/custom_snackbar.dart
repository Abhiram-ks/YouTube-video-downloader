import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:videodownload/core/theme/app_palette.dart';

class CustomSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    Color textColor = AppPalette.white,
    Color backgroundColor = Colors.black87,
    int durationSeconds = 3,
    EdgeInsetsGeometry? padding,
    TextAlign textAlign = TextAlign.center,
  }) {
    // Clear existing snackbars to prevent stacking
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: textAlign,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: textColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: backgroundColor,
        duration: Duration(seconds: durationSeconds),
        behavior: SnackBarBehavior.floating,
        margin: .zero,
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
        elevation: 0,
      ),
    );
  }
}
