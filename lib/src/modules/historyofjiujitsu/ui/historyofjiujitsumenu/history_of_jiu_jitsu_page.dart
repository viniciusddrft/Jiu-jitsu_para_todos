import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../shared/components/app_card.dart';
import '../../../../shared/components/app_top_bar.dart';
import '../../../../shared/l10n/app_localizations.dart';
import '../../../../shared/themes/app_colors.dart';
import '../../../../shared/themes/app_text_styles.dart';

class HistoryOfJiuJitsuPage extends StatelessWidget {
  const HistoryOfJiuJitsuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final chapters = [
      (
        l10n.history_japan_tag,
        l10n.button_jiujitsu_in_japao,
        '/historyojiujitsu/jiujitsuinjapan'
      ),
      (
        l10n.history_india_tag,
        l10n.button_jiujitsu_in_india,
        '/historyojiujitsu/jiujitsuinindia'
      ),
      (
        l10n.history_brazil_tag,
        l10n.button_jiujitsu_in_brazil,
        '/historyojiujitsu/jiujitsuinbrazil'
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 32),
          children: [
            AppTopBar(eyebrow: l10n.button_history_of_jiujitsu_home_page),
            PageHeading(l10n.history_heading,
                description: l10n.history_of_jiujitsu_page_summary),
            const SizedBox(height: 28),
            for (var i = 0; i < chapters.length; i++)
              _TimelineItem(
                key: Key('history_$i'),
                number: i + 1,
                highlighted: i == 0,
                isLast: i == chapters.length - 1,
                tag: chapters[i].$1,
                title: chapters[i].$2,
                onTap: () => context.pushNamed(chapters[i].$3),
              ),
          ],
        ),
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({
    super.key,
    required this.number,
    required this.highlighted,
    required this.isLast,
    required this.tag,
    required this.title,
    required this.onTap,
  });

  final int number;
  final bool highlighted, isLast;
  final String tag, title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 40,
                child: Column(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: highlighted
                            ? AppColors.accent
                            : AppColors.surfaceHigh,
                        border: highlighted
                            ? null
                            : Border.all(color: AppColors.line),
                      ),
                      child: Text('0$number',
                          style: AppTextStyles.display(18,
                              color: highlighted
                                  ? AppColors.background
                                  : AppColors.text)),
                    ),
                    if (!isLast)
                      Expanded(
                          child: Container(width: 2, color: AppColors.line)),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : 14),
                  child: AppCard(
                    onTap: onTap,
                    padding: const EdgeInsets.all(18),
                    radius: 20,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(tag.toUpperCase(),
                                  style: AppTextStyles.eyebrow()),
                              const SizedBox(height: 6),
                              Text(title.toUpperCase(),
                                  style: AppTextStyles.title(26)),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right_rounded,
                            color: AppColors.textMuted),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
