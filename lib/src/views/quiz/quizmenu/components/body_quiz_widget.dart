import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/views/quiz/quizmenu/components/components/button_options_quiz_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class BodyQuiz extends StatefulWidget {
  @override
  _BodyQuizState createState() => _BodyQuizState();
}

class _BodyQuizState extends State<BodyQuiz> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ButtonOptionQuiz(
              imageButton: 'assets/images/iconsbutton/faixabranca.png',
              textButton: 'button_white_belt_level'.tr(),
              difficulty: 'easy',
              difficultyName: 'text_difficultyname_white_belt'.tr(),
            ),
            ButtonOptionQuiz(
              imageButton: 'assets/images/iconsbutton/faixaazul.png',
              textButton: 'button_blue_belt_level'.tr(),
              difficulty: 'medium',
              difficultyName: 'text_difficultyname_blue_belt'.tr(),
            ),
            ButtonOptionQuiz(
              imageButton: 'assets/images/iconsbutton/faixapreta.png',
              textButton: 'button_black_belt_level'.tr(),
              difficulty: 'hard',
              difficultyName: 'text_difficultyname_black_belt'.tr(),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            )
          ],
        ),
      ),
    );
  }
}
