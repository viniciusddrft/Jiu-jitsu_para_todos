import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../shared/appbar_gradient/appbar_gradient.dart';
import '../../../../shared/themes/app_colors.dart';
import '../../../../shared/themes/app_icons_path.dart';

import 'components/button_options_quiz_widget.dart';

class QuizView extends StatefulWidget {
  const QuizView({super.key});
  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  late final Size size;
  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const AppBarGradient(),
        title: Text(AppLocalizations.of(context)!.title_appbar_quiz_page,
            style: const TextStyle(fontFamily: 'YatraOne')),
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ButtonOptionQuiz(
              context,
              imageButton: AppIconsPath.faixaBranca,
              textButton: AppLocalizations.of(context)!.button_white_belt_level,
              difficulty: 'easy',
              difficultyName:
                  AppLocalizations.of(context)!.text_difficultyname_white_belt,
            ),
            ButtonOptionQuiz(
              context,
              imageButton: AppIconsPath.faixaAzul,
              textButton: AppLocalizations.of(context)!.button_blue_belt_level,
              difficulty: 'medium',
              difficultyName:
                  AppLocalizations.of(context)!.text_difficultyname_blue_belt,
            ),
            ButtonOptionQuiz(
              context,
              imageButton: AppIconsPath.faixaPreta,
              textButton: AppLocalizations.of(context)!.button_black_belt_level,
              difficulty: 'hard',
              difficultyName:
                  AppLocalizations.of(context)!.text_difficultyname_black_belt,
            ),
          ],
        ),
      ),
    );
  }
}
