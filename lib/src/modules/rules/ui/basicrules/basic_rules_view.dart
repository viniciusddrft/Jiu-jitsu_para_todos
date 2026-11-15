import 'package:material_ui/material_ui.dart';

import '../../../../shared/components/app_card.dart';
import '../../../../shared/components/app_top_bar.dart';
import '../../../../shared/components/native_ad_slot.dart';
import '../../../../shared/l10n/app_localizations.dart';
import '../../../../shared/themes/app_colors.dart';
import '../../../../shared/themes/app_text_styles.dart';

class BasicRulesPage extends StatelessWidget {
  const BasicRulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.only(bottom: 32),
          children: [
            AppTopBar(eyebrow: l10n.title_appbar_basic_rules_page),
            _Section(title: l10n.text_overview_title, body: l10n.text_overview),
            _Section(title: l10n.text_scores_title, body: l10n.text_scores),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
              child: Column(
                children: [
                  _PointsCard(
                    points: 2,
                    title: l10n.text_moves_that_gives_2_scores_title,
                    items: [
                      l10n.text_throws,
                      l10n.text_knee_in_belly,
                      l10n.text_sweep,
                    ],
                  ),
                  const SizedBox(height: 10),
                  _PointsCard(
                    points: 3,
                    title: l10n.text_moves_that_gives_3_scores_title,
                    items: [
                      l10n.text_moves_that_gives_3_scores,
                      l10n.text_guard_pass,
                    ],
                  ),
                  const SizedBox(height: 10),
                  _PointsCard(
                    points: 4,
                    highlighted: true,
                    title: l10n.text_moves_that_gives_4_scores_title,
                    items: [l10n.text_mount, l10n.text_backward_grip],
                  ),
                ],
              ),
            ),
            _Section(
              title: l10n.text_advantage_and_penalties_title,
              body: l10n.text_advantage_and_penalties,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NativeAdSlot(),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.body});

  final String title, body;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title.toUpperCase(), style: AppTextStyles.display(34)),
            const SizedBox(height: 10),
            Text(body, style: AppTextStyles.body(size: 15)),
          ],
        ),
      );
}

class _PointsCard extends StatelessWidget {
  const _PointsCard({
    required this.points,
    required this.title,
    required this.items,
    this.highlighted = false,
  });

  final int points;
  final String title;
  final List<String> items;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final color = highlighted ? AppColors.accent : AppColors.text;
    return AppCard(
      radius: 18,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      borderColor: highlighted ? AppColors.accent : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 32,
            child:
                Text('$points', style: AppTextStyles.display(44, color: color)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title.toUpperCase(), style: AppTextStyles.title(20)),
                for (final item in items) ...[
                  const SizedBox(height: 8),
                  Text(item,
                      style: AppTextStyles.body(
                          size: 14, color: AppColors.textMuted, height: 1.5)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
