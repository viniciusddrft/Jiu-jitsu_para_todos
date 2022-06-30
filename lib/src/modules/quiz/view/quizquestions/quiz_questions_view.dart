import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../shared/admob/controller/admob_controller.dart';
import '../../../../shared/services/sound/plugin_sound_implements_just_audio.dart';
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
  //quiz controller
  final ControllerQuiz _controllerQuiz = ControllerQuiz();
  //quiz
  String? _difficultyName;
  //disablebutton for all buttons
  bool isButtonDisabled = false;
  //build video
  //song buttons
  final ServiceJustAudio _playerAudio = ServiceJustAudio();
  // colors buttons
  Color colorButtonA = Colors.white;
  Color colorButtonB = Colors.white;
  Color colorButtonC = Colors.white;
  Color colorButtonD = Colors.white;
  //icon button
  IconData? iconButtonA, iconButtonB, iconButtonC, iconButtonD;
  // colors icon
  Color? colorIconButtonA, colorIconButtonB, colorIconButtonC, colorIconButtonD;

  int get counterQuestions => _controllerQuiz.numberOfQuestions + 1;
  int get totalNumberOfQuestions => _controllerQuiz.myQuestions.length;

  @override
  void initState() {
    _difficultyName = widget.difficultyName;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    AdmobController.createInterstitialAd();

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _playerAudio.dispose();
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
            'totalQuestions': totalNumberOfQuestions
          });

//------------------------------------------------------------------------------
  void buttonQuestionsOnPressed(String answer, String orderOfQuestions) {
    if (_controllerQuiz.checkAnswer(answer)) {
      _playSoundRightAnswer();
      isButtonDisabled = true;
      if (orderOfQuestions == 'A') {
        setState(() {
          iconButtonA = Icons.done;
          colorButtonA = Colors.green;
          colorIconButtonA = Colors.green;
        });
      } else {
        if (orderOfQuestions == 'B') {
          setState(() {
            iconButtonB = Icons.done;
            colorButtonB = Colors.green;
            colorIconButtonB = Colors.green;
          });
        } else {
          if (orderOfQuestions == 'C') {
            setState(() {
              iconButtonC = Icons.done;
              colorButtonC = Colors.green;
              colorIconButtonC = Colors.green;
            });
          } else {
            if (orderOfQuestions == 'D') {
              setState(() {
                iconButtonD = Icons.done;
                colorButtonD = Colors.green;
                colorIconButtonD = Colors.green;
              });
            }
          }
        }
      }

      Future.delayed(
          const Duration(milliseconds: 500),
          () => setState(() {
                if (counterQuestions == _controllerQuiz.myQuestions.length ||
                    counterQuestions > _controllerQuiz.myQuestions.length) {
                  _controllerQuiz.score++;
                  AdmobController.showInterstitialAd();
                  _switchToResult();
                } else {
                  _controllerQuiz.numberOfQuestions++;
                  _controllerQuiz.score++;
                }
                colorButtonA = Colors.white;
                colorButtonB = Colors.white;
                colorButtonC = Colors.white;
                colorButtonD = Colors.white;
                iconButtonA = null;
                iconButtonB = null;
                iconButtonC = null;
                iconButtonD = null;
                isButtonDisabled = false;
              }));
    } else {
      _playSoundWrongAnswer();
      isButtonDisabled = true;
      if (orderOfQuestions == 'A') {
        setState(() {
          iconButtonA = Icons.close;
          colorButtonA = Colors.red;
          colorIconButtonA = Colors.red;
        });
      } else {
        if (orderOfQuestions == 'B') {
          setState(() {
            iconButtonB = Icons.close;
            colorButtonB = Colors.red;
            colorIconButtonB = Colors.red;
          });
        } else {
          if (orderOfQuestions == 'C') {
            setState(() {
              iconButtonC = Icons.close;
              colorButtonC = Colors.red;
              colorIconButtonC = Colors.red;
            });
          } else {
            if (orderOfQuestions == 'D') {
              setState(() {
                iconButtonD = Icons.close;
                colorButtonD = Colors.red;
                colorIconButtonD = Colors.red;
              });
            }
          }
        }
      }

      Future.delayed(
        const Duration(milliseconds: 500),
        () => setState(
          () {
            colorButtonA = Colors.white;
            colorButtonB = Colors.white;
            colorButtonC = Colors.white;
            colorButtonD = Colors.white;
            iconButtonA = null;
            iconButtonB = null;
            iconButtonC = null;
            iconButtonD = null;
            isButtonDisabled = false;
            if (counterQuestions == _controllerQuiz.myQuestions.length ||
                counterQuestions > _controllerQuiz.myQuestions.length) {
              AdmobController.showInterstitialAd();
              _switchToResult();
            } else {
              _controllerQuiz.numberOfQuestions++;
            }
          },
        ),
      );
    }
  }

//------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

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
                ? SizedBox(
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
                            'Quiz $_difficultyName',
                            style: TextStyle(
                                fontFamily: 'YatraOne',
                                fontSize: 20,
                                color: Colors.grey[700]),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: size.width * 0.07),
                          child: Text(
                            '${AppLocalizations.of(context)!.text_question} $counterQuestions/$totalNumberOfQuestions',
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
                                      isButtonDisabled: isButtonDisabled,
                                      answer:
                                          _controllerQuiz.returnTextAnswerA(),
                                      orderOfQuestions: 'A',
                                      colorButton: colorButtonA,
                                      colorIcon: colorIconButtonA,
                                      icon: iconButtonA,
                                    ),
                                    ButtonQuizQuestions(
                                      onPressed: buttonQuestionsOnPressed,
                                      isButtonDisabled: isButtonDisabled,
                                      answer:
                                          _controllerQuiz.returnTextAnswerB(),
                                      orderOfQuestions: 'B',
                                      colorButton: colorButtonB,
                                      colorIcon: colorIconButtonB,
                                      icon: iconButtonB,
                                    ),
                                    ButtonQuizQuestions(
                                      onPressed: buttonQuestionsOnPressed,
                                      isButtonDisabled: isButtonDisabled,
                                      answer:
                                          _controllerQuiz.returnTextAnswerC(),
                                      orderOfQuestions: 'C',
                                      colorButton: colorButtonC,
                                      colorIcon: colorIconButtonC,
                                      icon: iconButtonC,
                                    ),
                                    ButtonQuizQuestions(
                                      onPressed: buttonQuestionsOnPressed,
                                      isButtonDisabled: isButtonDisabled,
                                      answer:
                                          _controllerQuiz.returnTextAnswerD(),
                                      orderOfQuestions: 'D',
                                      colorButton: colorButtonD,
                                      colorIcon: colorIconButtonD,
                                      icon: iconButtonD,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
      ),
    );
  }
}
