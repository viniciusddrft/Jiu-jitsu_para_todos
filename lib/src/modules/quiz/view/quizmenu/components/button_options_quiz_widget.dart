import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../shared/button_for_menu/button_for_menu.dart';

class ButtonOptionQuiz extends ButtonForMenu {
  final String difficulty;
  final String difficultyName;
  ButtonOptionQuiz(BuildContext context,
      {super.key,
      required super.imageButton,
      required super.textButton,
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
            ].contains(difficultyName));
  @override
  State<ButtonOptionQuiz> createState() => _ButtonOptionQuizState();
}

class _ButtonOptionQuizState extends State<ButtonOptionQuiz> {
  @override
  void didChangeDependencies() {
    precacheImage(Image.asset(widget.imageButton).image, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return widget.makeButton(
      context,
      changeRoute: () => Navigator.pushNamed(context, '/QuizQuestions',
          arguments: <String, String>{
            'difficulty': widget.difficulty,
            'difficultyName': widget.difficultyName
          }),
    );
  }
}
