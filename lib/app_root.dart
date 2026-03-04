
import 'package:flutter/material.dart';
import 'package:videodownload/src/presentation/screen/navi_root.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  BottomNavigationControllers();
  }
}
