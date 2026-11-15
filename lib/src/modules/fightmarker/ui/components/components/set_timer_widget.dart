import 'package:material_ui/material_ui.dart';

import '../../../../../shared/components/belt.dart';
import '../../../../../shared/l10n/app_localizations.dart';
import '../../../../../shared/plugins/haptics/app_haptics.dart';
import '../../../../../shared/themes/app_colors.dart';
import '../../../../../shared/themes/app_text_styles.dart';
import '../../../interactor/clock_interactor.dart';

/// Definir o tempo da luta: atalhos por faixa (tempos da categoria adulto)
/// ou minutos e segundos livres.
class SetTimerWidget extends StatefulWidget {
  const SetTimerWidget({super.key, required this.clockInteractor});

  final ClockInteractor clockInteractor;

  @override
  State<SetTimerWidget> createState() => _SetTimerWidgetState();
}

class _SetTimerWidgetState extends State<SetTimerWidget> {
  static const _presets = [
    (BeltColor.white, 5),
    (BeltColor.blue, 6),
    (BeltColor.purple, 7),
    (BeltColor.brown, 8),
    (BeltColor.black, 10),
  ];

  late final _minutes = FixedExtentScrollController(
      initialItem: widget.clockInteractor.time ~/ 60);
  late final _seconds = FixedExtentScrollController(
      initialItem: widget.clockInteractor.time % 60);

  @override
  void dispose() {
    _minutes.dispose();
    _seconds.dispose();
    super.dispose();
  }

  // Enquanto um atalho anima as rodas, os "tiques" de cada número ficam
  // desligados: o atalho já vibrou uma vez.
  bool _animatingPreset = false;

  Future<void> _applyPreset(int minutes) async {
    AppHaptics.selection();
    _animatingPreset = true;
    await Future.wait([
      _minutes.animateToItem(minutes,
          duration: const Duration(milliseconds: 250), curve: Curves.easeOut),
      _seconds.animateToItem(0,
          duration: const Duration(milliseconds: 250), curve: Curves.easeOut),
    ]);
    _animatingPreset = false;
  }

  void _onWheelTick(int _) {
    if (!_animatingPreset) AppHaptics.selection();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 640),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.text_label_time_popup.toUpperCase(),
                        style: AppTextStyles.display(28)),
                    const SizedBox(height: 14),
                    Text(l10n.fightmarker_presets.toUpperCase(),
                        style: AppTextStyles.eyebrow()),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        for (final (belt, minutes) in _presets)
                          Material(
                            color: AppColors.surfaceHigh,
                            borderRadius: BorderRadius.circular(14),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(14),
                              onTap: () => _applyPreset(minutes),
                              child: SizedBox(
                                width: 66,
                                height: 60,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Belt(belt: belt, width: 40, height: 7),
                                    const SizedBox(height: 8),
                                    Text('$minutes ${l10n.fightmarker_minutes}',
                                        style: AppTextStyles.title(17)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _Wheel(controller: _minutes, onTick: _onWheelTick),
                      Text(':', style: AppTextStyles.display(44)),
                      _Wheel(controller: _seconds, onTick: _onWheelTick),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                            foregroundColor: AppColors.text),
                        child: Text(l10n.text_label_cancel_popup),
                      ),
                      const SizedBox(width: 8),
                      FilledButton(
                        style: FilledButton.styleFrom(
                            backgroundColor: AppColors.accent,
                            foregroundColor: AppColors.background),
                        onPressed: () {
                          widget.clockInteractor.setTime(
                              _minutes.selectedItem, _seconds.selectedItem);
                          Navigator.pop(context);
                        },
                        child: Text(l10n.text_label_continue),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Wheel extends StatelessWidget {
  const _Wheel({required this.controller, required this.onTick});

  final FixedExtentScrollController controller;
  final ValueChanged<int> onTick;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 80,
        height: 150,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Faixa de seleção atrás do valor escolhido.
            Container(
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.surfaceHigh,
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            ListWheelScrollView.useDelegate(
              controller: controller,
              itemExtent: 52,
              physics: const FixedExtentScrollPhysics(),
              onSelectedItemChanged: onTick,
              perspective: 0.004,
              diameterRatio: 1.4,
              overAndUnderCenterOpacity: 0.3,
              childDelegate: ListWheelChildBuilderDelegate(
                childCount: 60,
                builder: (context, i) => Center(
                  child: Text(i.toString().padLeft(2, '0'),
                      style: AppTextStyles.display(40)),
                ),
              ),
            ),
          ],
        ),
      );
}
