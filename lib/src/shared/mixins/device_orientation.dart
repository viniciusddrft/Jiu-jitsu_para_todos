import 'package:flutter/services.dart';
import 'package:wakelock/wakelock.dart';

mixin DeviceOrientationApp {
  Future<void> configPortrait() async {
    await Wakelock.disable();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  Future<void> configLandscape() async {
    await Wakelock.enable();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
}
