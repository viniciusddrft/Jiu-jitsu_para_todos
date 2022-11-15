import 'package:flutter/material.dart';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../shared/services/sound/service_sound_implements_just_audio.dart';
import '../../../../../shared/themes/app_colors.dart';
import '../../../controller/clock_controller.dart';

import 'components/set_timer_widget.dart';

class Clock extends StatefulWidget {
  const Clock({super.key});
  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  final MyClock myClock = MyClock();
  final ServiceJustAudio _playerAudio = ServiceJustAudio();

  @override
  void dispose() {
    _playerAudio.dispose();
    myClock.dispose();
    super.dispose();
  }

  Future<void> _showMyDialogstopsound() => showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppColors.background,
            actions: <Widget>[
              TextButton(
                child:
                    Text(AppLocalizations.of(context)!.text_button_stopsound),
                onPressed: () {
                  _playerAudio.stop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          child: CircularCountDownTimer(
            duration: myClock.time,
            controller: myClock.controller,
            autoStart: false,
            width: size.width * 0.33,
            height: size.height * 0.33,
            textFormat: CountdownTextFormat.MM_SS,
            ringColor: Colors.white,
            fillColor: Colors.green,
            backgroundColor: null,
            strokeWidth: 5.0,
            strokeCap: StrokeCap.butt,
            textStyle: GoogleFonts.yatraOne(fontSize: 30),
            isReverse: true,
            isReverseAnimation: false,
            isTimerTextShown: true,
            onComplete: () {
              _playerAudio.play('assets/music/alarm_sound.mp3');
              _showMyDialogstopsound();
            },
          ),
          onTap: () => showDialog<void>(
            context: context,
            builder: (BuildContext context) => SetTimerWidget(myClock: myClock),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: size.height * 0.05),
          child: SizedBox(
            width: size.width * 0.15,
            child: ValueListenableBuilder(
              valueListenable: myClock.isPause,
              builder: (BuildContext context, bool value, Widget? child) =>
                  OutlinedButton(
                style: OutlinedButton.styleFrom(
                    foregroundColor:
                        myClock.isPause.value ? Colors.green : Colors.red,
                    elevation: 7,
                    backgroundColor: AppColors.background,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    side: BorderSide(
                        color:
                            myClock.isPause.value ? Colors.green : Colors.red)),
                onPressed: myClock.startAndPauseButton,
                child: Center(
                  child: Icon(
                      myClock.isPause.value ? Icons.play_arrow : Icons.pause,
                      color: myClock.isPause.value ? Colors.green : Colors.red),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: size.height * 0.01),
          child: SizedBox(
            width: size.width * 0.15,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                elevation: 7,
                foregroundColor: Colors.yellow,
                backgroundColor: AppColors.background,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                side: const BorderSide(color: Colors.yellow),
              ),
              onPressed: myClock.restartButton,
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
