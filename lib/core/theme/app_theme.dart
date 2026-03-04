import 'package:bizforz/core/theme/app_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  // Light Theme
  static final lightTheme = ThemeData(
    primaryColor: AppPalette.blue,
    brightness: .light,
    scaffoldBackgroundColor: AppPalette.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppPalette.white,
      selectedItemColor: AppPalette.black,
      unselectedItemColor: AppPalette.grey,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPalette.blue,
      iconTheme: IconThemeData(color: AppPalette.black),
    ),
    textTheme: TextTheme(
      displayLarge:  TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600, color: AppPalette.black),
      displaySmall:  TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
      bodyLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: AppPalette.black75),
      bodyMedium: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppPalette.black80),
      bodySmall:  TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: AppPalette.black80),
      labelLarge:  TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400, color: AppPalette.black80),
      labelMedium: TextStyle(fontSize: 9.sp, fontWeight: FontWeight.w400, color: AppPalette.black80,),
      labelSmall: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w400, color: AppPalette.black80),
    ),
  );
}
