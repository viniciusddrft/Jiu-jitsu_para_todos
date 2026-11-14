import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_ui/material_ui.dart';

import '../../../shared/components/app_card.dart';
import '../../../shared/components/belt.dart';
import '../../../shared/l10n/app_localizations.dart';
import '../../../shared/plugins/analytics/analytics_interactor.dart';
import '../../../shared/themes/app_colors.dart';
import '../../../shared/themes/app_text_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final analytics = inject<AnalyticsInteractor>();
    final l10n = AppLocalizations.of(context)!;

    void open(String feature, String route) {
      analytics.logFeatureAccess(feature);
      context.pushNamed(route);
    }

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 24),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 12, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BrandBelt(),
                        const SizedBox(height: 8),
                        Text(l10n.title_appbar_home_page.toUpperCase(),
                            style: AppTextStyles.display(22)),
                      ],
                    ),
                  ),
                  IconButton.filled(
                    key: const Key('settingsButton'),
                    tooltip: l10n.title_appbar_settings_page,
                    onPressed: () => open('settings', '/settings/settings'),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.surface,
                      foregroundColor: AppColors.text,
                      fixedSize: const Size(48, 48),
                    ),
                    icon: const Icon(Icons.settings_outlined),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Text.rich(
                TextSpan(children: [
                  TextSpan(text: '${l10n.home_greeting.toUpperCase()}\n'),
                  TextSpan(
                    text: l10n.home_greeting_subtitle.toUpperCase(),
                    style: const TextStyle(color: AppColors.textMuted),
                  ),
                ]),
                style: AppTextStyles.display(52),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: _QuizCard(onTap: () => open('quiz', '/quiz/menu')),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.25,
                children: [
                  FeatureCard(
                    key: const Key('home_history'),
                    icon: Icons.menu_book_outlined,
                    title: l10n.button_history_of_jiujitsu_home_page,
                    subtitle: l10n.home_history_subtitle,
                    onTap: () =>
                        open('history', '/historyojiujitsu/historyojiujitsu'),
                  ),
                  FeatureCard(
                    key: const Key('home_rules'),
                    icon: Icons.description_outlined,
                    title: l10n.button_rules_home_page,
                    subtitle: l10n.home_rules_subtitle,
                    onTap: () => open('rules', '/rules/rules'),
                  ),
                  FeatureCard(
                    key: const Key('home_fightmarker'),
                    icon: Icons.timer_outlined,
                    title: l10n.button_fight_marker_home_page,
                    subtitle: l10n.home_fightmarker_subtitle,
                    onTap: () => open('fightmarker', '/fightmaker/fightmaker'),
                  ),
                  FeatureCard(
                    key: const Key('home_wallpapers'),
                    icon: Icons.wallpaper_outlined,
                    title: l10n.button_wallpapers_home_page,
                    subtitle: l10n.home_wallpapers_subtitle,
                    onTap: () => open('wallpaper', '/wallpaper/wallpapers'),
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

class _QuizCard extends StatelessWidget {
  const _QuizCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final levels = {
      BeltColor.white: l10n.text_difficultyname_white_belt,
      BeltColor.blue: l10n.text_difficultyname_blue_belt,
      BeltColor.black: l10n.text_difficultyname_black_belt,
    };
    return AppCard(
      key: const Key('quizCard'),
      onTap: onTap,
      radius: 24,
      borderColor: AppColors.line,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.button_quiz_home_page.toUpperCase(),
                        style: AppTextStyles.eyebrow(color: AppColors.accent)),
                    const SizedBox(height: 6),
                    Text(l10n.home_quiz_title.toUpperCase(),
                        style: AppTextStyles.title(30)),
                    const SizedBox(height: 4),
                    Text(l10n.home_quiz_subtitle,
                        style: AppTextStyles.body(
                            size: 14, color: AppColors.textMuted)),
                  ],
                ),
              ),
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                    color: AppColors.accent, shape: BoxShape.circle),
                child: const Icon(Icons.arrow_forward_rounded,
                    color: AppColors.background),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              for (final MapEntry(key: belt, value: name)
                  in levels.entries) ...[
                if (belt != BeltColor.white) const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LayoutBuilder(
                        builder: (context, c) =>
                            Belt(belt: belt, width: c.maxWidth, height: 8),
                      ),
                      const SizedBox(height: 6),
                      Text(name,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.body(size: 12, height: 1.2)),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

/// Cartão de atalho da Início (ícone, título e subtítulo).
class FeatureCard extends StatelessWidget {
  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title, subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => AppCard(
        onTap: onTap,
        radius: 20,
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.text, size: 26),
            const Spacer(),
            Text(title.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.title(22)),
            const SizedBox(height: 2),
            Text(subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.body(
                    size: 12, color: AppColors.textMuted, height: 1.3)),
          ],
        ),
      );
}
