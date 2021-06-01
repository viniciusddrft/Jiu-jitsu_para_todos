import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/controllers/clock/clock_controller.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  MyClock _myClock = MyClock();
  final _player = AudioPlayer();

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

//------------------------------------------------------------------------------
  Future<void> _showMyDialogMinutes() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xff202848),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  onChanged: (minutes) {
                    _myClock.minutes = int.parse(minutes) * 60;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      icon: Icon(Icons.timer),
                      labelText: 'text_label_minutes_popup'.tr(),
                      border: OutlineInputBorder()),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('text_button_popup_continue'.tr()),
              onPressed: () {
                _myClock.minuteButtonPressed();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

//------------------------------------------------------------------------------
  Future<void> _showMyDialogSeconds() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xff202848),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  onChanged: (seconds) {
                    _myClock.seconds = int.parse(seconds);
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      icon: Icon(Icons.timer),
                      labelText: 'text_label_seconds_popup'.tr(),
                      border: OutlineInputBorder()),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('text_button_popup_continue'.tr()),
              onPressed: () {
                if (_myClock.secondsButtonPressed()) {
                  setState(() {
                    _myClock.isPause = true;
                  });
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

//------------------------------------------------------------------------------

  Future<void> _showMyDialogstopsound() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xff202848),
          actions: <Widget>[
            TextButton(
              child: Text('text_button_stopsound'.tr()),
              onPressed: () async {
                await _player.pause();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

//------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            child: CircularCountDownTimer(
              // Countdown duration in Seconds
              duration: _myClock.time,

              // Controller to control (i.e Pause, Resume, Restart) the Countdown
              controller: _myClock.controller,

              autoStart: false,

              // Width of the Countdown Widget
              width: MediaQuery.of(context).size.width / 3,

              // Height of the Countdown Widget
              height: MediaQuery.of(context).size.height / 3,

              textFormat: CountdownTextFormat.MM_SS,
              // Default Color for Countdown Timer
              ringColor: Colors.white,

              // Filling Color for Countdown Timer
              fillColor: Colors.green,

              // Background Color for Countdown Widget
              backgroundColor: null,

              // Border Thickness of the Countdown Circle
              strokeWidth: 14.0.sp,

              // Begin and end contours with a flat edge and no extension
              strokeCap: StrokeCap.butt,

              // Text Style for Countdown Text
              textStyle: TextStyle(fontSize: 60.0.sp, fontFamily: 'YatraOne'),

              // true for reverse countdown (max to 0), false for forward countdown (0 to max)
              isReverse: true,

              // true for reverse animation, false for forward animation
              isReverseAnimation: false,

              // Optional [bool] to hide the [Text] in this widget.
              isTimerTextShown: true,

              // Function which will execute when the Countdown Ends
              onComplete: () async {
                //mysound.playsound('alarm_sound.mp3');
                await _player.setAsset('assets/music/alarm_sound.mp3');
                _player.play();
                _showMyDialogstopsound();
              },
            ),
            onTap: () {
              _showMyDialogSeconds();
              _showMyDialogMinutes();
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 12,
          ),
          ConstrainedBox(
            constraints: BoxConstraints.tightFor(
                width: MediaQuery.of(context).size.width / 9,
                height: MediaQuery.of(context).size.height / 12),
            child: Container(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    elevation: 7,
                    primary: _myClock.isPause ? Colors.green : Colors.red,
                    backgroundColor: Color(0xff202848),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    side: BorderSide(
                        color: _myClock.isPause ? Colors.green : Colors.red)),
                onPressed: () {
                  setState(() {
                    _myClock.startAndPauseButton();
                  });
                },
                child: Center(
                  child: Center(
                    child: Icon(
                        _myClock.isPause ? Icons.play_arrow : Icons.pause,
                        color: _myClock.isPause ? Colors.green : Colors.red),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 15,
          ),
          ConstrainedBox(
            constraints: BoxConstraints.tightFor(
                width: MediaQuery.of(context).size.width / 9,
                height: MediaQuery.of(context).size.height / 12),
            child: Container(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    elevation: 7,
                    primary: Colors.yellow,
                    backgroundColor: Color(0xff202848),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    side: BorderSide(color: Colors.yellow)),
                onPressed: () {
                  setState(() {
                    _myClock.restartButton();
                  });
                },
                child: Center(
                  child: Center(
                    child: Icon(
                      Icons.refresh_rounded,
                      color: Colors.yellow,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
