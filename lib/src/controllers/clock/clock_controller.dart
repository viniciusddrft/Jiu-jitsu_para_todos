import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class MyClock {
  int? minutes;
  int? seconds;
  int time;
  int? timeOld;
  bool isPause;
  CountDownController controller = CountDownController();

  MyClock({
    this.minutes,
    this.seconds,
    this.time = 0,
    this.isPause = true,
  });

  void minuteButtonPressed() {
    if (minutes == null) {
      minutes = 0;
    }
    timeOld = time;
    time = minutes!;
    minutes = 0;
  }

  bool secondsButtonPressed() {
    if (seconds == null) {
      seconds = 0;
    }
    time += seconds!;
    if (time > 0) {
      controller.restart(duration: time);
      controller.pause();
      seconds = 0;
      return true;
    }
    if (time == 0) {
      time = timeOld!;
    }
    return false;
  }

  void startAndPauseButton() {
    if (isPause) {
      isPause = false;
      controller.resume();
    } else {
      isPause = true;
      controller.pause();
    }
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
  }
}
