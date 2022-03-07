import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/shared/button_for_menu/button_for_menu.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ButtonOptionQuiz extends ButtonForMenu {
  final String difficulty;
  final String difficultyName;
  ButtonOptionQuiz(BuildContext context,
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
              AppLocalizations.of(context)!.button_white_belt_level,
              AppLocalizations.of(context)!.button_blue_belt_level,
              AppLocalizations.of(context)!.button_black_belt_level
            ].contains(textButton) &&
            ['easy', 'medium', 'hard'].contains(difficulty) &&
            [
              AppLocalizations.of(context)!.text_difficultyname_white_belt,
              AppLocalizations.of(context)!.text_difficultyname_blue_belt,
              AppLocalizations.of(context)!.text_difficultyname_black_belt
            ].contains(difficultyName)),
        super(key: key, imageButton: imageButton, textButton: textButton);
  @override
  _ButtonOptionQuizState createState() => _ButtonOptionQuizState();
}

class _ButtonOptionQuizState extends State<ButtonOptionQuiz> {
  void changeRoute() => Navigator.pushNamed(context, '/QuizQuestions',
          arguments: <String, String>{
            'difficulty': widget.difficulty,
            'difficultyName': widget.difficultyName
          });

  @override
  Widget build(BuildContext context) {
    return widget.makeButton(context, changeRoute: changeRoute);
  }
}
