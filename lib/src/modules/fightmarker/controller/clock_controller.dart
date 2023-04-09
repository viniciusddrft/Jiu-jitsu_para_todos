import 'package:flutter/widgets.dart';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class MyClockController {
  int time = 0;
  final isPause = ValueNotifier<bool>(true);
  final controller = CountDownController();

  void setTime(int minutes, int seconds) {
    time = ((minutes * 60) + seconds);
    controller.restart(duration: time);
    controller.pause();
  }

  void startAndPauseButton() {
    if (isPause.value) {
      isPause.value = false;
      controller.resume();
    } else {
      isPause.value = true;
      controller.pause();
    }
  }

  void restartButton() {
    if (time != 0) {
      controller.restart(duration: time);
      if (isPause.value) {
        controller.pause();
      } else {
        isPause.value = true;
        controller.pause();
      }
    }
  }

  void dispose() => isPause.dispose();
}
