import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/modules/fightmarker/controller/clock_controller.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class Clock extends StatefulWidget {
  Clock();
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  final MyClock _myClock = MyClock();
  final _player = AudioPlayer();

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

//------------------------------------------------------------------------------
  Future<void> _showMyDialogMinutes() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.background,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  onChanged: (minutes) =>
                      _myClock.minutes = int.parse(minutes) * 60,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      icon: const Icon(Icons.timer),
                      labelText: 'text_label_minutes_popup'.tr(),
                      border: const OutlineInputBorder()),
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
  Future<void> _showMyDialogSeconds() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.background,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  onChanged: (seconds) => _myClock.seconds = int.parse(seconds),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      icon: const Icon(Icons.timer),
                      labelText: 'text_label_seconds_popup'.tr(),
                      border: const OutlineInputBorder()),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('text_button_popup_continue'.tr()),
              onPressed: () {
                if (_myClock.secondsButtonPressed()) {
                  setState(() => _myClock.isPause = true);
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

  Future<void> _showMyDialogstopsound() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.background,
          actions: <Widget>[
            TextButton(
              child: Text('text_button_stopsound'.tr()),
              onPressed: () =>
                  _player.pause().then((_) => Navigator.of(context).pop()),
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
              duration: _myClock.time,
              controller: _myClock.controller,
              autoStart: false,
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.height / 3,
              textFormat: CountdownTextFormat.MM_SS,
              ringColor: Colors.white,
              fillColor: Colors.green,
              backgroundColor: null,
              strokeWidth: 14.0.sp,
              strokeCap: StrokeCap.butt,
              textStyle: TextStyle(fontSize: 60.0.sp, fontFamily: 'YatraOne'),
              isReverse: true,
              isReverseAnimation: false,
              isTimerTextShown: true,
              onComplete: () {
                _player.setAsset('assets/music/alarm_sound.mp3');
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
                    backgroundColor: AppColors.background,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    side: BorderSide(
                        color: _myClock.isPause ? Colors.green : Colors.red)),
                onPressed: () => setState(() => _myClock.startAndPauseButton()),
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
                    backgroundColor: AppColors.background,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    side: BorderSide(color: Colors.yellow)),
                onPressed: () => setState(() => _myClock.restartButton()),
                child: Center(
                  child: Center(
                    child: const Icon(
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
