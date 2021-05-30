import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class MyClock {
  int? minutes;
  int? seconds;
  int time;
  int? timeold;
  bool ispause;
  CountDownController controller = CountDownController();

  MyClock({
    this.minutes,
    this.seconds,
    this.time = 0,
    this.ispause = true,
  });

  void minutebuttonpressed() {
    if (minutes == null) {
      minutes = 0;
    }
    timeold = time;
    time = minutes!;
    minutes = 0;
  }

  bool secondsbuttonpressed() {
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
      time = timeold!;
    }
    return false;
  }

  void startandpausebutton() {
    if (ispause) {
      ispause = false;
      controller.resume();
    } else {
      ispause = true;
      controller.pause();
    }
  }

  void restartbutton() {
    if (time != 0) {
      controller.restart(duration: time);
      if (ispause) {
        controller.pause();
      } else {
        ispause = true;
        controller.pause();
      }
    }
  }
}
