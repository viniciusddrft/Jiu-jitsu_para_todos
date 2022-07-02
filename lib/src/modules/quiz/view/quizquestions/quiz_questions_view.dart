import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../shared/admob/controller/admob_controller.dart';
import '../../../../shared/services/sound/service_sound_implements_just_audio.dart';
import '../../../../shared/themes/app_colors.dart';
import '../../controller/quiz_controller.dart';

import 'components/button_quiz_questions_widget.dart';

class QuizQuestions extends StatefulWidget {
  final String difficulty;
  final String difficultyName;
  QuizQuestions(
      {super.key, required this.difficulty, required this.difficultyName})
      : assert(['easy', 'medium', 'hard'].contains(difficulty));

  @override
  State<QuizQuestions> createState() => _QuizQuestionsState();
}

class _QuizQuestionsState extends State<QuizQuestions> {
  final ControllerQuiz _controllerQuiz = ControllerQuiz();

  final ServiceJustAudio _playerAudio = ServiceJustAudio();

  late final Size size;

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    AdmobController.createInterstitialAd();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _playerAudio.dispose();
    _controllerQuiz.dispose();
    super.dispose();
  }

//------------------------------------------------------------------------------
  void _playSoundRightAnswer() =>
      _playerAudio.play('assets/music/right_answer.mp3');
//------------------------------------------------------------------------------
  void _playSoundWrongAnswer() =>
      _playerAudio.play('assets/music/wrong_answer.mp3');
//------------------------------------------------------------------------------
  void _switchToResult() =>
      Navigator.pushReplacementNamed(context, '/ResultQuiz',
          arguments: <String, dynamic>{
            'difficultyName': widget.difficultyName,
            'score': _controllerQuiz.score,
            'totalQuestions': _controllerQuiz.totalNumberOfQuestions
          });

//------------------------------------------------------------------------------
  void buttonQuestionsOnPressed(String answer, String orderOfQuestions) {
    if (_controllerQuiz.checkAnswer(answer)) {
      _playSoundRightAnswer();
      if (orderOfQuestions == 'A') {
        _controllerQuiz.paintButtonA(isRight: true);
      } else {
        if (orderOfQuestions == 'B') {
          _controllerQuiz.paintButtonB(isRight: true);
        } else {
          if (orderOfQuestions == 'C') {
            _controllerQuiz.paintButtonC(isRight: true);
          } else {
            if (orderOfQuestions == 'D') {
              _controllerQuiz.paintButtonD(isRight: true);
            }
          }
        }
      }
    } else {
      _playSoundWrongAnswer();
      if (orderOfQuestions == 'A') {
        _controllerQuiz.paintButtonA(isRight: false);
      } else {
        if (orderOfQuestions == 'B') {
          _controllerQuiz.paintButtonB(isRight: false);
        } else {
          if (orderOfQuestions == 'C') {
            _controllerQuiz.paintButtonC(isRight: false);
          } else {
            if (orderOfQuestions == 'D') {
              _controllerQuiz.paintButtonD(isRight: false);
            }
          }
        }
      }
    }
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        _controllerQuiz.cleanButtons();
        if (_controllerQuiz.counterQuestions ==
                _controllerQuiz.myQuestions.length ||
            _controllerQuiz.counterQuestions >
                _controllerQuiz.myQuestions.length) {
          AdmobController.showInterstitialAd();
          _switchToResult();
        } else {
          _controllerQuiz.nextQuestion();
        }
      },
    );
  }

//------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: AppColors.background,
      body: FutureBuilder(
        future: _controllerQuiz.choice(difficulty: widget.difficulty),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) =>
            (snapshot.connectionState == ConnectionState.done)
                ? AnimatedBuilder(
                    animation: _controllerQuiz,
                    builder: (BuildContext context, Widget? child) => SizedBox(
                      width: size.width,
                      height: size.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: size.width * 0.07,
                                bottom: size.height * 0.01),
                            child: Text(
                              'Quiz ${widget.difficultyName}',
                              style: TextStyle(
                                  fontFamily: 'YatraOne',
                                  fontSize: 20,
                                  color: Colors.grey[700]),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: size.width * 0.07),
                            child: Text(
                              '${AppLocalizations.of(context)!.text_question} ${_controllerQuiz.counterQuestions}/${_controllerQuiz.totalNumberOfQuestions}',
                              style: const TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 22,
                                  color: Colors.white),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: size.width * 0.07,
                                right: size.width * 0.07),
                            width: size.width,
                            height: 1,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.white, AppColors.background],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: size.height * 0.03,
                                left: size.width * 0.07,
                                right: size.width * 0.07),
                            child: Text(
                              _controllerQuiz.textQuestionReturn(),
                              style: const TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.07),
                                  color: Colors.transparent,
                                  child: Column(
                                    children: [
                                      ButtonQuizQuestions(
                                        onPressed: buttonQuestionsOnPressed,
                                        isButtonDisabled:
                                            _controllerQuiz.isButtonDisabled,
                                        answer:
                                            _controllerQuiz.returnTextAnswerA(),
                                        orderOfQuestions: 'A',
                                        colorButton:
                                            _controllerQuiz.colorButtonA,
                                        colorIcon:
                                            _controllerQuiz.colorIconButtonA,
                                        icon: _controllerQuiz.iconButtonA,
                                      ),
                                      ButtonQuizQuestions(
                                        onPressed: buttonQuestionsOnPressed,
                                        isButtonDisabled:
                                            _controllerQuiz.isButtonDisabled,
                                        answer:
                                            _controllerQuiz.returnTextAnswerB(),
                                        orderOfQuestions: 'B',
                                        colorButton:
                                            _controllerQuiz.colorButtonB,
                                        colorIcon:
                                            _controllerQuiz.colorIconButtonB,
                                        icon: _controllerQuiz.iconButtonB,
                                      ),
                                      ButtonQuizQuestions(
                                        onPressed: buttonQuestionsOnPressed,
                                        isButtonDisabled:
                                            _controllerQuiz.isButtonDisabled,
                                        answer:
                                            _controllerQuiz.returnTextAnswerC(),
                                        orderOfQuestions: 'C',
                                        colorButton:
                                            _controllerQuiz.colorButtonC,
                                        colorIcon:
                                            _controllerQuiz.colorIconButtonC,
                                        icon: _controllerQuiz.iconButtonC,
                                      ),
                                      ButtonQuizQuestions(
                                        onPressed: buttonQuestionsOnPressed,
                                        isButtonDisabled:
                                            _controllerQuiz.isButtonDisabled,
                                        answer:
                                            _controllerQuiz.returnTextAnswerD(),
                                        orderOfQuestions: 'D',
                                        colorButton:
                                            _controllerQuiz.colorButtonD,
                                        colorIcon:
                                            _controllerQuiz.colorIconButtonD,
                                        icon: _controllerQuiz.iconButtonD,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
      ),
    );
  }
}
