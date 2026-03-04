import 'package:flutter/services.dart';

class MainHelper {
  /// Set preferred device orientations to portrait only
  static Future<void> setPreferredOrientations() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  /// Initialize all app
  static Future<void> initialize() async {
    await setPreferredOrientations();
  }
}