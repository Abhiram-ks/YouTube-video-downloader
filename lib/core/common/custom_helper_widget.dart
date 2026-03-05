import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:videodownload/core/constants/app_constant.dart';
import 'package:videodownload/core/theme/app_palette.dart';

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