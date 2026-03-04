import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Constant {
  static SizedBox height(double value) {
    return SizedBox(height: value.h);
  }

  static SizedBox width(double value) {
    return SizedBox(width: value.w);
  }
}
