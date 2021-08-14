import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/view/quizresult/result_quiz.dart';
import 'package:jiu_jitsu_para_todos/src/shared/admob/controller/admob_controller.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/controller/quiz_controller.dart';
import 'package:jiu_jitsu_para_todos/src/shared/animated_page_route_builder/my_transition_elatic_out.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/view/quizquestions/components/button_quiz_questions_widget.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/view/quizquestions/components/return_midia_quiz_widget.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class QuizQuestions extends StatefulWidget {
  final String difficulty;
  final String difficultyName;
  QuizQuestions({required this.difficulty, required this.difficultyName})
      : assert(['easy', 'medium', 'hard'].contains(difficulty) &&
            [
              'text_difficultyname_white_belt'.tr(),
              'text_difficultyname_blue_belt'.tr(),
              'text_difficultyname_black_belt'.tr()
            ].contains(difficultyName));

  @override
  _QuizQuestionsState createState() => _QuizQuestionsState();
}

class _QuizQuestionsState extends State<QuizQuestions> {
  //quiz controller
  final ControllerQuiz _controllerQuiz = ControllerQuiz();
  //quiz
  var _myQuestions;
  String? _difficultyName;
  //disablebutton for all buttons
  bool isButtonDisabled = false;
  //build video
  bool _buildVideo = true;
  //song buttons
  final AudioPlayer _playerRightAnswer = AudioPlayer();
  final AudioPlayer _playerWrongAnswer = AudioPlayer();
  // colors buttons
  Color colorButtonA = Colors.white;
  Color colorButtonB = Colors.white;
  Color colorButtonC = Colors.white;
  Color colorButtonD = Colors.white;
  //icon button
  IconData? iconButtonA;
  IconData? iconButtonB;
  IconData? iconButtonC;
  IconData? iconButtonD;
  // colors icon
  Color? colorIconButtonA;
  Color? colorIconButtonB;
  Color? colorIconButtonC;
  Color? colorIconButtonD;

  @override
  void initState() {
    _myQuestions = _controllerQuiz.choice(widget.difficulty);
    _difficultyName = widget.difficultyName;
    super.initState();
  }

  @override
  void dispose() {
    _playerRightAnswer.dispose();
    _playerWrongAnswer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    int counterQuestions = _controllerQuiz.numberOfQuestions + 1;
    int totalNumberOfQuestions = _myQuestions!.length;
//------------------------------------------------------------------------------
    void _playSoundRightAnswer() => _playerRightAnswer
        .setAsset('assets/music/right_answer.mp3')
        .then((_) => _playerRightAnswer.play());
//------------------------------------------------------------------------------
    void _playSoundWrongAnswer() => _playerWrongAnswer
        .setAsset('assets/music/wrong_answer.mp3')
        .then((_) => _playerWrongAnswer.play());
//------------------------------------------------------------------------------
    void _switchToResult() => Navigator.of(context).pushReplacement(
          MyTransitionElasticOut(
            route: ResultQuiz(
                difficultyName: widget.difficultyName,
                score: _controllerQuiz.score,
                totalQuestions: totalNumberOfQuestions),
            duration: Duration(milliseconds: 500),
          ),
        );
//------------------------------------------------------------------------------
    void buttonQuestionsOnPressed(String answer, String orderOfQuestions) {
      if (_controllerQuiz.checkAnswer(answer, _myQuestions)) {
        _playSoundRightAnswer();
        isButtonDisabled = true;
        if (orderOfQuestions == 'A')
          setState(() {
            iconButtonA = Icons.done;
            colorButtonA = Colors.green;
            colorIconButtonA = Colors.green;
          });
        else if (orderOfQuestions == 'B')
          setState(() {
            iconButtonB = Icons.done;
            colorButtonB = Colors.green;
            colorIconButtonB = Colors.green;
          });
        else if (orderOfQuestions == 'C')
          setState(() {
            iconButtonC = Icons.done;
            colorButtonC = Colors.green;
            colorIconButtonC = Colors.green;
          });
        else if (orderOfQuestions == 'D')
          setState(() {
            iconButtonD = Icons.done;
            colorButtonD = Colors.green;
            colorIconButtonD = Colors.green;
          });

        Future.delayed(
            const Duration(milliseconds: 500),
            () => setState(() {
                  if (counterQuestions == _myQuestions!.length ||
                      counterQuestions > _myQuestions!.length) {
                    _controllerQuiz.score++;
                    Admob.createAndShowInterstitialAd();
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
        if (orderOfQuestions == 'A')
          setState(() {
            iconButtonA = Icons.close;
            colorButtonA = Colors.red;
            colorIconButtonA = Colors.red;
          });
        else if (orderOfQuestions == 'B')
          setState(() {
            iconButtonB = Icons.close;
            colorButtonB = Colors.red;
            colorIconButtonB = Colors.red;
          });
        else if (orderOfQuestions == 'C')
          setState(() {
            iconButtonC = Icons.close;
            colorButtonC = Colors.red;
            colorIconButtonC = Colors.red;
          });
        else if (orderOfQuestions == 'D')
          setState(() {
            iconButtonD = Icons.close;
            colorButtonD = Colors.red;
            colorIconButtonD = Colors.red;
          });

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
              if (counterQuestions == _myQuestions!.length ||
                  counterQuestions > _myQuestions!.length) {
                Admob.createAndShowInterstitialAd();
                _switchToResult();
              } else
                _controllerQuiz.numberOfQuestions++;
            },
          ),
        );
      }
    }

//------------------------------------------------------------------------------
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: AppColors.background,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 30.w, bottom: 10.h),
              child: Text(
                'Quiz $_difficultyName',
                style: TextStyle(
                    fontFamily: 'YatraOne',
                    fontSize: 20.sp,
                    color: Colors.grey[700]),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.w),
              child: Text(
                'text_question'.tr() +
                    ' $counterQuestions/$totalNumberOfQuestions',
                style: TextStyle(
                    fontFamily: 'Ubuntu', fontSize: 22.sp, color: Colors.white),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30.w, right: 30.w),
              width: MediaQuery.of(context).size.width,
              height: 1.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.white, AppColors.background],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 30.w, right: 30.w),
              child: Text(
                _controllerQuiz.textQuestionReturn(_myQuestions),
                style: TextStyle(
                    fontFamily: 'Ubuntu', fontSize: 18.sp, color: Colors.white),
              ),
            ),
            returnImageOrVideoOfQuiz(
                _controllerQuiz, _myQuestions, _buildVideo),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.w),
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        ButtonQuizQuestions(
                          onPressed: buttonQuestionsOnPressed,
                          isButtonDisabled: isButtonDisabled,
                          answer:
                              _controllerQuiz.returnTextAnswerA(_myQuestions),
                          orderOfQuestions: 'A',
                          colorButton: colorButtonA,
                          colorIcon: colorIconButtonA,
                          icon: iconButtonA,
                        ),
                        ButtonQuizQuestions(
                          onPressed: buttonQuestionsOnPressed,
                          isButtonDisabled: isButtonDisabled,
                          answer:
                              _controllerQuiz.returnTextAnswerB(_myQuestions),
                          orderOfQuestions: 'B',
                          colorButton: colorButtonB,
                          colorIcon: colorIconButtonB,
                          icon: iconButtonB,
                        ),
                        ButtonQuizQuestions(
                          onPressed: buttonQuestionsOnPressed,
                          isButtonDisabled: isButtonDisabled,
                          answer:
                              _controllerQuiz.returnTextAnswerC(_myQuestions),
                          orderOfQuestions: 'C',
                          colorButton: colorButtonC,
                          colorIcon: colorIconButtonC,
                          icon: iconButtonC,
                        ),
                        ButtonQuizQuestions(
                          onPressed: buttonQuestionsOnPressed,
                          isButtonDisabled: isButtonDisabled,
                          answer:
                              _controllerQuiz.returnTextAnswerD(_myQuestions),
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
      ),
    );
  }
}
