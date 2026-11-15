import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../shared/components/app_card.dart';
import '../../../../shared/components/app_top_bar.dart';
import '../../../../shared/l10n/app_localizations.dart';
import '../../../../shared/themes/app_colors.dart';
import '../../../../shared/themes/app_text_styles.dart';

class RulesPage extends StatelessWidget {
  const RulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final summary = [
      ('2', l10n.rules_summary_2, AppColors.text),
      ('3', l10n.rules_summary_3, AppColors.text),
      ('4', l10n.rules_summary_4, AppColors.accent),
    ];

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 32),
          children: [
            AppTopBar(eyebrow: l10n.title_appbar_rule_page),
            PageHeading(l10n.rules_heading),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (var i = 0; i < summary.length; i++) ...[
                      if (i > 0) const SizedBox(width: 8),
                      Expanded(
                        child: AppCard(
                          radius: 16,
                          padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(summary[i].$1,
                                  style: AppTextStyles.display(40,
                                      color: summary[i].$3)),
                              const SizedBox(height: 4),
                              Text(summary[i].$2,
                                  style: AppTextStyles.body(
                                      size: 12,
                                      color: AppColors.textMuted,
                                      height: 1.35)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: Column(
                children: [
                  NavCard(
                    key: const Key('rules_basic'),
                    icon: Icons.menu_book_outlined,
                    title: l10n.button_basic_rules,
                    subtitle: l10n.rules_basic_subtitle,
                    onTap: () => context.pushNamed('/rules/basicrules'),
                  ),
                  const SizedBox(height: 12),
                  NavCard(
                    key: const Key('rules_cbjj'),
                    icon: Icons.picture_as_pdf_outlined,
                    title: l10n.button_cbjj_Rules,
                    subtitle: l10n.rules_cbjj_subtitle,
                    onTap: () => context.pushNamed('/rules/cbjjrules'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
