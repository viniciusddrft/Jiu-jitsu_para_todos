import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/interector/interfaces/ifirebase_quiz.dart';
import 'package:jiu_jitsu_para_todos/src/shared/plugins/admob/admob_interector.dart';

import '../../../../shared/themes/app_colors.dart';

class QuizResultPage extends StatefulWidget {
  final int score, totalQuestions;
  final Difficult difficult;

  const QuizResultPage(
      {required this.score,
      required this.difficult,
      required this.totalQuestions,
      super.key});
  @override
  State<QuizResultPage> createState() => _QuizResultPageState();
}

class _QuizResultPageState extends State<QuizResultPage>
    with SingleTickerProviderStateMixin {
  late String _iconPath, _textShowResult, _textMessage, _scorePercentageText;
  late final double _scorePercentage;
  late final AnimationController _animationController;

  final admobInterector = Modular.get<AdmobInterector>();

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

    if (widget.difficult == Difficult.easy) {
      _textShowResult =
          AppLocalizations.of(context)!.text_result_quiz_white_belt;
    } else if (widget.difficult == Difficult.medium) {
      _textShowResult =
          AppLocalizations.of(context)!.text_result_quiz_blue_belt;
    } else if (widget.difficult == Difficult.hard) {
      _textShowResult =
          AppLocalizations.of(context)!.text_result_quiz_black_belt;
    }

    _animationController
        .animateTo(
          _scorePercentage,
          duration: const Duration(seconds: 2),
          curve: Curves.elasticInOut,
        )
        .whenComplete(
          () => Future.delayed(
              const Duration(seconds: 1), admobInterector.showInterstitialAd),
        );

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

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
                style: GoogleFonts.ubuntu(fontSize: 20),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.05),
              child: SizedBox(
                width: size.width * 0.7,
                child: Center(
                  child: Text(
                    _textShowResult,
                    style: GoogleFonts.ubuntu(fontSize: 20),
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
                        style: GoogleFonts.ubuntu(fontSize: 30),
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

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
