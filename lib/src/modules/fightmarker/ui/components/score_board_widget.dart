import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../shared/l10n/app_localizations.dart';
import '../../../../shared/themes/app_colors.dart';
import '../../../../shared/themes/app_text_styles.dart';
import '../../interactor/scorreboard_interactor.dart';

/// Placar de um atleta. Toque soma; segurar desfaz.
/// O atleta 1 usa o cartão claro e o 2 o escuro, para os dois lados serem
/// distinguíveis de longe (sem faixas: elas indicariam um nível que não existe).
class Scoreboard extends StatefulWidget {
  const Scoreboard({super.key, required this.athlete, this.light = false});

  final int athlete;
  final bool light;

  @override
  State<Scoreboard> createState() => _ScoreboardState();
}

class _ScoreboardState extends State<Scoreboard> {
  final _scoreboardInteractor = inject<ScoreboardInteractor>();

  @override
  void dispose() {
    _scoreboardInteractor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final light = widget.light;
    final fg = light ? AppColors.background : AppColors.text;
    final muted = light ? const Color(0xff4A505C) : AppColors.textSoft;
    final s = _scoreboardInteractor;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: light ? AppColors.text : AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: light ? null : Border.all(color: AppColors.line),
      ),
      child: AnimatedBuilder(
        animation: s,
        builder: (context, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.fightmarker_athlete(widget.athlete),
                style: AppTextStyles.label(size: 13, color: fg)),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      fit: BoxFit.scaleDown,
                      child: Text('${s.fighterPoints}',
                          key: Key('points_${widget.athlete}'),
                          style: AppTextStyles.display(110, color: fg)
                              .copyWith(height: 1)),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _Counter(
                          label: l10n.text_abbreviated_advantage,
                          value: s.advantagesOfTheFighter,
                          color: fg,
                          muted: muted),
                      const SizedBox(height: 6),
                      _Counter(
                          label: l10n.text_abbreviated_punishment,
                          value: s.punishmentsOfTheFighter,
                          color: fg,
                          muted: muted),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                for (final points in const [2, 3, 4]) ...[
                  if (points != 2) const SizedBox(width: 6),
                  Expanded(
                    child: _ScoreButton(
                      label: '+$points',
                      big: true,
                      light: light,
                      onTap: () => s.addPoints(points),
                      onLongPress: () => s.removePoints(points),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: _ScoreButton(
                    label: l10n.fightmarker_advantage,
                    outlined: true,
                    light: light,
                    onTap: s.addAdvantages,
                    onLongPress: s.removeAdvantages,
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: _ScoreButton(
                    label: l10n.fightmarker_penalty,
                    outlined: true,
                    light: light,
                    onTap: s.addPunishments,
                    onLongPress: s.removePunishments,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Counter extends StatelessWidget {
  const _Counter({
    required this.label,
    required this.value,
    required this.color,
    required this.muted,
  });

  final String label;
  final int value;
  final Color color, muted;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text('$value', style: AppTextStyles.display(30, color: color)),
          const SizedBox(width: 4),
          Text(label, style: AppTextStyles.label(size: 13, color: muted)),
        ],
      );
}

class _ScoreButton extends StatelessWidget {
  const _ScoreButton({
    required this.label,
    required this.light,
    required this.onTap,
    required this.onLongPress,
    this.big = false,
    this.outlined = false,
  });

  final String label;
  final bool light, big, outlined;
  final VoidCallback onTap, onLongPress;

  @override
  Widget build(BuildContext context) {
    final filledBg = light ? AppColors.background : AppColors.text;
    final filledFg = light ? AppColors.text : AppColors.background;
    final outlineFg = light ? AppColors.background : AppColors.text;
    final outlineColor = light ? AppColors.background : AppColors.textMuted;

    return Material(
      color: outlined ? Colors.transparent : filledBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: outlined
            ? BorderSide(color: outlineColor, width: 1.5)
            : BorderSide.none,
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: SizedBox(
          height: big ? 44 : 40,
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Text(
                  label,
                  style: big
                      ? AppTextStyles.title(22,
                          color: outlined ? outlineFg : filledFg)
                      : AppTextStyles.label(
                          size: 13, color: outlined ? outlineFg : filledFg),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
