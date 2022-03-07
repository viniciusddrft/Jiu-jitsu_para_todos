import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/view/quizmenu/components/components/button_options_quiz_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_icons_path.dart';

class BodyQuiz extends StatefulWidget {
  const BodyQuiz({Key? key}) : super(key: key);
  @override
  _BodyQuizState createState() => _BodyQuizState();
}

class _BodyQuizState extends State<BodyQuiz> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return SizedBox(
      height: _size.height,
      width: _size.height,
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
