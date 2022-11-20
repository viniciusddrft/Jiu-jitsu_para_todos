import 'package:flutter/services.dart';
import 'package:wakelock/wakelock.dart';

mixin DeviceOrientationApp {
  Future<void> configPortrait() async {
    Wakelock.disable();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  Future<void> configLandscape() async {
    Wakelock.enable();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
}
