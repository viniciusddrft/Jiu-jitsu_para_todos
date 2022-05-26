import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../shared/themes/app_icons_path.dart';
import 'components/button_options_quiz_widget.dart';

class BodyQuiz extends StatefulWidget {
  const BodyQuiz({super.key});
  @override
  State<BodyQuiz> createState() => _BodyQuizState();
}

class _BodyQuizState extends State<BodyQuiz> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      width: size.height,
      child: SingleChildScrollView(
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
