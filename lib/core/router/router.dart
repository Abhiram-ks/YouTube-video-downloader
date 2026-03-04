import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:videodownload/app_root.dart';
import 'package:videodownload/src/presentation/screen/video_player/video_player_screen.dart';

import '../constants/app_constant.dart';

class AppRoute {
  AppRoute._();
  static final AppRoute instance = AppRoute._();
  factory AppRoute() => instance;

  final GoRouter router = GoRouter(
    initialLocation: AppRoutes.appRoot,
    routes: [
      GoRoute(
        path: AppRoutes.appRoot,
        name: AppRoutes.appRoot,
        builder: (context, state) => const AppRoot(),
      ),
      GoRoute(
        path: AppRoutes.videoPlayer,
        name: AppRoutes.videoPlayer,
        builder: (context, state) {
          final extras = state.extra as Map<String, dynamic>;
          return VideoPlayerScreen(
            url: extras['url'] as String,
            title: extras['title'] as String,
            isLocal: extras['isLocal'] as bool? ?? false,
          );
        },
      ),
    ],

    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Page Not Found',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Constant.height(20),
              Text(
                'The page you were looking for could not be found. '
                'It might have been removed, renamed, or does not exist.',
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(fontSize: 16.sp, height: 1.4.h),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class AppRoutes {
  static const String appRoot = '/';
  static const String videoPlayer = '/videoPlayer';
}
