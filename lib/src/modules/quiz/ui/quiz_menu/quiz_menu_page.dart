import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../shared/components/app_card.dart';
import '../../../../shared/components/app_top_bar.dart';
import '../../../../shared/components/belt.dart';
import '../../../../shared/l10n/app_localizations.dart';
import '../../../../shared/themes/app_colors.dart';
import '../../../../shared/themes/app_text_styles.dart';
import '../../interactor/interfaces/ifirebase_quiz.dart';
import '../difficulty_ui.dart';

class QuizMenuPage extends StatelessWidget {
  const QuizMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 32),
          children: [
            AppTopBar(eyebrow: l10n.title_appbar_quiz_page),
            PageHeading(l10n.quiz_menu_heading,
                description: l10n.quiz_menu_description),
            const SizedBox(height: 28),
            for (final level in Difficult.values)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: _LevelCard(level: level),
              ),
          ],
        ),
      ),
    );
  }
}

class _LevelCard extends StatelessWidget {
  const _LevelCard({required this.level});

  final Difficult level;

  @override
  Widget build(BuildContext context) => AppCard(
        key: Key('quizLevel_${level.name}'),
        onTap: () => context.pushNamed('/quiz/questions', arguments: level),
        borderColor: level == Difficult.hard ? AppColors.line : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LayoutBuilder(
              builder: (context, c) =>
                  Belt(belt: level.belt, width: c.maxWidth, height: 16),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(level.levelName(context).toUpperCase(),
                          style: AppTextStyles.title(26)),
                      const SizedBox(height: 4),
                      Text(level.description(context),
                          style: AppTextStyles.body(
                              size: 13, color: AppColors.textMuted)),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded,
                    color: AppColors.textMuted),
              ],
            ),
          ],
        ),
      );
}
