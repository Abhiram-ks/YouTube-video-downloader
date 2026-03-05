import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:videodownload/core/di/di.dart';
import 'package:videodownload/core/router/router.dart';
import 'package:videodownload/core/theme/app_theme.dart';
import 'package:videodownload/main_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MainHelper.initialize();
  await init();
  runApp(const RunApp());
}

class RunApp extends StatelessWidget {
  const RunApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp.router(
          title: 'iSARGO',
          theme: AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          routerConfig: AppRoute.instance.router,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(
               context,
              ).copyWith(textScaler: TextScaler.linear(1.0)),
              child: child!,
            );
          },
        );
      },
    );
  }
}
