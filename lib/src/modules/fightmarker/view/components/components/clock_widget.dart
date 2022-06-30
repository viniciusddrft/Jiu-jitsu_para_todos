import 'package:flutter/material.dart';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../shared/services/sound/plugin_sound_implements_just_audio.dart';
import '../../../../../shared/themes/app_colors.dart';
import '../../../controller/clock_controller.dart';

class Clock extends StatefulWidget {
  const Clock({super.key});
  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  final MyClock _myClock = MyClock();

  final ServiceJustAudio _playerAudio = ServiceJustAudio();

  //this setState fixes the size of texts on this screen due to rotation
  @override
  void didChangeDependencies() {
    Future.delayed(Duration.zero, () => setState(() {}));
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _playerAudio.dispose();
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
                    labelText:
                        AppLocalizations.of(context)!.text_label_minutes_popup,
                    border: const OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                  AppLocalizations.of(context)!.text_button_popup_continue),
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
                      labelText: AppLocalizations.of(context)!
                          .text_label_seconds_popup,
                      border: const OutlineInputBorder()),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                  AppLocalizations.of(context)!.text_button_popup_continue),
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
              child: Text(AppLocalizations.of(context)!.text_button_stopsound),
              onPressed: () {
                _playerAudio.stop();
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
    final Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: size.height * 0.1),
          child: GestureDetector(
            child: CircularCountDownTimer(
              duration: _myClock.time,
              controller: _myClock.controller,
              autoStart: false,
              width: size.width * 0.3333,
              height: size.height * 0.3333,
              textFormat: CountdownTextFormat.MM_SS,
              ringColor: Colors.white,
              fillColor: Colors.green,
              backgroundColor: null,
              strokeWidth: 5.0,
              strokeCap: StrokeCap.butt,
              textStyle:
                  const TextStyle(fontSize: 30.0, fontFamily: 'YatraOne'),
              isReverse: true,
              isReverseAnimation: false,
              isTimerTextShown: true,
              onComplete: () {
                _playerAudio.play('assets/music/alarm_sound.mp3');
                _showMyDialogstopsound();
              },
            ),
            onTap: () {
              _showMyDialogSeconds();
              _showMyDialogMinutes();
            },
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints.tightFor(
            width: size.width * 0.11,
            height: size.height * 0.085,
          ),
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
              child: Icon(_myClock.isPause ? Icons.play_arrow : Icons.pause,
                  color: _myClock.isPause ? Colors.green : Colors.red),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: size.height * 0.05),
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(
              width: size.width * 0.11,
              height: size.height * 0.085,
            ),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                elevation: 7,
                primary: Colors.yellow,
                backgroundColor: AppColors.background,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                side: const BorderSide(color: Colors.yellow),
              ),
              onPressed: () => setState(() => _myClock.restartButton()),
              child: const Center(
                child: Icon(
                  Icons.refresh_rounded,
                  color: Colors.yellow,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
