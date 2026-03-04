
import 'package:flutter/material.dart';
import 'package:videodownload/core/theme/app_palette.dart';

BoxDecoration customBoxDecoration({
  Color color = AppPalette.white,
  Color shadowColor = const Color(0xff000000),
  double shadowOpacity = 0.15,
  double blurRadius = 2,
  double spreadRadius = 0,
  Offset offset = const Offset(0, 1),
  double borderRadius = 15,
  BoxShape shape = BoxShape.rectangle,
  bool isBackgroundRequired = true,
}) {
  return BoxDecoration(
    color: color,
    shape: shape,
    borderRadius: shape == BoxShape.circle
        ? null
        : BorderRadius.circular(borderRadius),
    boxShadow: isBackgroundRequired
        ? [
            BoxShadow(
              color: shadowColor.withValues(alpha: shadowOpacity),
              offset: offset,
              blurRadius: blurRadius,
              spreadRadius: spreadRadius,
            ),
          ]
        : null,
  );
}
