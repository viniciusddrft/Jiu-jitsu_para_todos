import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiu_jitsu_para_todos/src/modules/fightmarker/interactor/clock_interactor.dart';
import '../../../../shared/themes/app_colors.dart';
import 'components/set_timer_widget.dart';

class Clock extends StatefulWidget {
  const Clock({super.key});
  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  final _clockInteractor = Modular.get<ClockInteractor>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          child: CircularCountDownTimer(
            duration: _clockInteractor.time,
            controller: _clockInteractor.controller,
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
              _clockInteractor.playSound();
              showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) => AlertDialog(
                  backgroundColor: AppColors.background,
                  actions: <Widget>[
                    TextButton(
                      child: Text(
                          AppLocalizations.of(context)!.text_button_stopsound),
                      onPressed: () {
                        _clockInteractor.stopSound();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          onTap: () => showDialog<void>(
            context: context,
            builder: (BuildContext context) => SetTimerWidget(
              clockInteractor: _clockInteractor,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: size.height * 0.05),
          child: SizedBox(
            width: size.width * 0.15,
            child: AnimatedBuilder(
              animation: _clockInteractor,
              builder: (BuildContext context, Widget? child) => OutlinedButton(
                style: OutlinedButton.styleFrom(
                    foregroundColor:
                        _clockInteractor.isPause ? Colors.green : Colors.red,
                    elevation: 7,
                    backgroundColor: AppColors.background,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    side: BorderSide(
                        color: _clockInteractor.isPause
                            ? Colors.green
                            : Colors.red)),
                onPressed: _clockInteractor.startAndPauseButton,
                child: Center(
                  child: Icon(
                      _clockInteractor.isPause ? Icons.play_arrow : Icons.pause,
                      color:
                          _clockInteractor.isPause ? Colors.green : Colors.red),
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
              onPressed: _clockInteractor.restartButton,
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

  @override
  void dispose() {
    _clockInteractor.dispose();
    super.dispose();
  }
}
