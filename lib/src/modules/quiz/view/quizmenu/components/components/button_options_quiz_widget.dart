import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/shared/button_for_menu/button_for_menu.dart';
import 'package:easy_localization/easy_localization.dart';

class ButtonOptionQuiz extends ButtonForMenu {
  final String difficulty;
  final String difficultyName;
  ButtonOptionQuiz(
      {Key? key,
      required imageButton,
      required textButton,
      required this.difficulty,
      required this.difficultyName})
      : assert([
              'assets/images/iconsbutton/faixabranca.png',
              'assets/images/iconsbutton/faixaazul.png',
              'assets/images/iconsbutton/faixapreta.png'
            ].contains(imageButton) &&
            [
              'button_white_belt_level'.tr(),
              'button_blue_belt_level'.tr(),
              'button_black_belt_level'.tr()
            ].contains(textButton) &&
            ['easy', 'medium', 'hard'].contains(difficulty) &&
            [
              'text_difficultyname_white_belt'.tr(),
              'text_difficultyname_blue_belt'.tr(),
              'text_difficultyname_black_belt'.tr()
            ].contains(difficultyName)),
        super(key: key, imageButton: imageButton, textButton: textButton);

  @override
  Widget build(BuildContext context) {
    void changeRoute() => Navigator.pushNamed(context, '/QuizQuestions',
            arguments: <String, String>{
              'difficulty': difficulty,
              'difficultyName': difficultyName
            });

    return makeButton(changeRoute);
  }
}
