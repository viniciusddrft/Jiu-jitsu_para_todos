import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../shared/admob/controller/admob_controller.dart';
import '../../../../shared/themes/app_colors.dart';

class ResultQuiz extends StatefulWidget {
  final int score, totalQuestions;
  final String difficultyName;

  const ResultQuiz(
      {required this.score,
      required this.difficultyName,
      required this.totalQuestions,
      super.key});
  @override
  State<ResultQuiz> createState() => _ResultQuizState();
}

class _ResultQuizState extends State<ResultQuiz>
    with SingleTickerProviderStateMixin {
  late final Size size = MediaQuery.of(context).size;
  late String _iconPath, _textShowResult, _textMessage, _scorePercentageText;
  late final double _scorePercentage;
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    _scorePercentage = widget.score / widget.totalQuestions;
    _scorePercentageText = (_scorePercentage * 100).toStringAsPrecision(2);
    if (_scorePercentage == 1.0) {
      _scorePercentageText = '100';
      _iconPath = 'assets/quiz/iconsresultquiz/victory.png';
      _textMessage = AppLocalizations.of(context)!.text_message_quiz_very_well;
    } else if (_scorePercentage >= 0.75 && _scorePercentage < 1.0) {
      _iconPath = 'assets/quiz/iconsresultquiz/reading-book.png';
      _textMessage = AppLocalizations.of(context)!.text_message_quiz_almost;
    } else {
      _iconPath = 'assets/quiz/iconsresultquiz/sad.png';
      _textMessage = AppLocalizations.of(context)!.text_message_quiz_sad;
    }
    precacheImage(Image.asset(_iconPath).image, context);

    if (widget.difficultyName ==
        AppLocalizations.of(context)!.text_difficultyname_white_belt) {
      _textShowResult =
          AppLocalizations.of(context)!.text_result_quiz_white_belt;
    } else if (widget.difficultyName ==
        AppLocalizations.of(context)!.text_difficultyname_blue_belt) {
      _textShowResult =
          AppLocalizations.of(context)!.text_result_quiz_blue_belt;
    } else if (widget.difficultyName ==
        AppLocalizations.of(context)!.text_difficultyname_black_belt) {
      _textShowResult =
          AppLocalizations.of(context)!.text_result_quiz_black_belt;
    }
    _animationController
        .animateTo(
          _scorePercentage,
          duration: const Duration(seconds: 2),
          curve: Curves.elasticInOut,
        )
        .then((_) => AdmobController.showInterstitialAd());

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: AppColors.background,
      body: SizedBox(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              _iconPath,
              height: 100,
              width: 100,
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.05),
              child: Text(
                _textMessage,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.05),
              child: SizedBox(
                width: size.width * 0.7,
                child: Center(
                  child: Text(
                    _textShowResult,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.1),
              child: SizedBox(
                height: 150,
                width: 150,
                child: Stack(
                  children: [
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: AnimatedBuilder(
                        animation: _animationController,
                        builder: (BuildContext context, Widget? child) =>
                            CircularProgressIndicator(
                          strokeWidth: 7,
                          value: _animationController.value,
                          backgroundColor: const Color(0xff313959),
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        '$_scorePercentageText%',
                        style: const TextStyle(fontSize: 30),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
