import 'package:flutter/services.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

mixin DeviceOrientationApp {
  Future<void> configPortrait() async {
    await WakelockPlus.disable();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  Future<void> configLandscape() async {
    await WakelockPlus.enable();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
}
