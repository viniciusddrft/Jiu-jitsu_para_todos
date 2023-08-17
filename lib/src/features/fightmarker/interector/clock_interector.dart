import 'package:flutter/widgets.dart';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jiu_jitsu_para_todos/src/shared/plugins/sound/interface/sound_interface.dart';

class ClockInterector extends ChangeNotifier {
  int time = 0;
  bool isPause = true;
  final controller = CountDownController();
  final _soundInterface = Modular.get<SoundInterface>();

  void playSound() => _soundInterface.play('assets/music/alarm_sound.mp3');

  void stopSound() => _soundInterface.stop();

  void setTime(int minutes, int seconds) {
    time = ((minutes * 60) + seconds);
    controller.restart(duration: time);
    controller.pause();
  }

  void startAndPauseButton() {
    if (isPause) {
      isPause = false;
      controller.resume();
    } else {
      isPause = true;
      controller.pause();
    }
    notifyListeners();
  }

  void restartButton() {
    if (time != 0) {
      controller.restart(duration: time);
      if (isPause) {
        controller.pause();
      } else {
        isPause = true;
        controller.pause();
      }
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _soundInterface.dispose();
    super.dispose();
  }
}
