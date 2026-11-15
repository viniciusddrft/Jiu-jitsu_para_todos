import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../shared/l10n/app_localizations.dart';
import '../../../../shared/plugins/haptics/app_haptics.dart';
import '../../../../shared/themes/app_colors.dart';
import '../../../../shared/themes/app_text_styles.dart';
import '../../interactor/clock_interactor.dart';
import 'components/set_timer_widget.dart';

/// Relógio da luta: toque no tempo para definir; play/pausa e reiniciar.
class Clock extends StatefulWidget {
  const Clock({super.key});
  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  final _clockInteractor = inject<ClockInteractor>();

  void _openSetTime() => showDialog<void>(
        context: context,
        builder: (_) => SetTimerWidget(clockInteractor: _clockInteractor),
      );

  void _onComplete() {
    _clockInteractor.playSound();
    AppHaptics.alarm();
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: Text('00:00', style: AppTextStyles.display(56)),
        actions: <Widget>[
          FilledButton.icon(
            style: FilledButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: AppColors.background),
            icon: const Icon(Icons.volume_off_rounded),
            label: Text(AppLocalizations.of(context)!.text_button_stopsound),
            onPressed: () {
              _clockInteractor.stopSound();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _clockInteractor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return LayoutBuilder(
      builder: (context, constraints) {
        final ring = (constraints.maxHeight - 64)
            .clamp(80.0, constraints.maxWidth * 0.9);
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Semantics(
              button: true,
              label: l10n.fightmarker_set_time,
              child: GestureDetector(
                onTap: _openSetTime,
                child: CircularCountDownTimer(
                  duration: _clockInteractor.time,
                  controller: _clockInteractor.controller,
                  autoStart: false,
                  width: ring,
                  height: ring,
                  textFormat: CountdownTextFormat.MM_SS,
                  ringColor: AppColors.surfaceHigh,
                  fillColor: AppColors.accent,
                  backgroundColor: null,
                  strokeWidth: 6,
                  strokeCap: StrokeCap.round,
                  textStyle: AppTextStyles.display(ring * 0.24),
                  isReverse: true,
                  isReverseAnimation: false,
                  isTimerTextShown: true,
                  onComplete: _onComplete,
                ),
              ),
            ),
            const SizedBox(height: 12),
            AnimatedBuilder(
              animation: _clockInteractor,
              builder: (context, _) {
                final paused = _clockInteractor.isPause;
                // Encolhe em vez de estourar enquanto a tela gira para
                // paisagem (a coluna central fica estreita por um instante).
                return FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton.filled(
                        tooltip: paused ? 'Play' : 'Pause',
                        onPressed: () {
                          AppHaptics.key();
                          _clockInteractor.startAndPauseButton();
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          foregroundColor: AppColors.background,
                          fixedSize: const Size(52, 44),
                        ),
                        icon: Icon(paused
                            ? Icons.play_arrow_rounded
                            : Icons.pause_rounded),
                      ),
                      const SizedBox(width: 8),
                      IconButton.filled(
                        tooltip: MaterialLocalizations.of(context)
                            .refreshIndicatorSemanticLabel,
                        onPressed: () {
                          AppHaptics.key();
                          _clockInteractor.restartButton();
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.surface,
                          foregroundColor: AppColors.text,
                          fixedSize: const Size(52, 44),
                        ),
                        icon: const Icon(Icons.replay_rounded),
                      ),
                      const SizedBox(width: 8),
                      IconButton.filled(
                        tooltip: l10n.fightmarker_set_time,
                        onPressed: _openSetTime,
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.surface,
                          foregroundColor: AppColors.text,
                          fixedSize: const Size(52, 44),
                        ),
                        icon: const Icon(Icons.timer_outlined),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
