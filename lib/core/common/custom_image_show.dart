
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:videodownload/core/assets/assets.dart';
import 'package:videodownload/core/constants/app_constant.dart';
import 'package:videodownload/core/theme/app_palette.dart';

Column column({
  required BuildContext context,
}) {
  return Column(
  mainAxisAlignment: .center,
  crossAxisAlignment: .center,
  children: [
    Image.asset(applogo, height: 100.h, width: 100.w),
    Constant.height(6),
    Text(
      "iSARGO : Cinematic Stream",
      style: Theme.of(
        context,
      ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
    ),
    Text(
      "© 2026 Flutter Development.",
      style: Theme.of(
        context,
      ).textTheme.labelMedium?.copyWith(color: AppPalette.grey),
    ),
  ],
);
}
