import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiu_jitsu_para_todos/src/controllers/admob/admob_controller.dart';
import 'package:jiu_jitsu_para_todos/src/controllers/quiz/quiz_controller.dart';
import 'package:jiu_jitsu_para_todos/src/views/quiz/components/return_midia_quiz_widget.dart';
import 'package:jiu_jitsu_para_todos/src/views/quiz/failed_the_quiz_view.dart';
import 'package:jiu_jitsu_para_todos/src/views/quiz/winner_in_the_quiz_view.dart';
import 'package:jiu_jitsu_para_todos/src/views/shared/animated_page_route_builder/my_transition_elatic_out.dart';
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
  //quiz
  var _controllerQuiz = ControllerQuiz();
  var _myQuestions;
  var _difficultyName;
  //disablebutton
  bool _isButtonDisabled = false;
  //build video
  bool _buildVideo = true;
  //icon button
  var iconButton = Icons.done;
  //song buttons
  final _playerRightAnswer = AudioPlayer();
  final _playerWrongAnswer = AudioPlayer();
  // randomness for ads
  final _random = Random();
  var _num;
  // colors buttons
  var _colorButtonA = Colors.white;
  var _colorIconButtonA = Colors.transparent;
  var _colorButtonB = Colors.white;
  var _colorIconButtonB = Colors.transparent;
  var _colorButtonC = Colors.white;
  var _colorIconButtonC = Colors.transparent;
  var _colorButtonD = Colors.white;
  var _colorIconButtonD = Colors.transparent;

  @override
  void didChangeDependencies() {
    _myQuestions = _controllerQuiz.choice(widget.difficulty);
    _difficultyName = widget.difficultyName;
    super.didChangeDependencies();
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
    int totalNumberOfQuestions = _myQuestions.length;
//------------------------------------------------------------------------------
    void playSoundRightAnswer() async {
      await _playerRightAnswer.setAsset('assets/music/right_answer.mp3');
      _playerRightAnswer.play();
    }

//------------------------------------------------------------------------------
    void playSoundWrongAnswer() async {
      await _playerWrongAnswer.setAsset('assets/music/wrong_answer.mp3');
      _playerWrongAnswer.play();
    }

//------------------------------------------------------------------------------
    void _switchToWinner() async {
      _num = _random.nextInt(10);
      if (_num >= 8) {
        Admob.createAndShowInterstitialAd();
      }
      await Navigator.of(context).pushReplacement(MyTransitionElasticOut(
          route: WinnerInQuiz(
            difficultyName: widget.difficultyName,
          ),
          duration: Duration(milliseconds: 500)));
    }

//------------------------------------------------------------------------------
    void _switchToFailed() async {
      _num = _random.nextInt(10);
      if (_num >= 2) {
        Admob.createAndShowInterstitialAd();
      }
      await Navigator.of(context).pushReplacement(MyTransitionElasticOut(
          route: FailedInQuiz(
            difficultyName: widget.difficultyName,
            score: counterQuestions - 1,
            totalQuestions: totalNumberOfQuestions,
          ),
          duration: Duration(milliseconds: 500)));
    }

//------------------------------------------------------------------------------
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Color(0xff202848),
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
                    colors: [Colors.white, Color(0xff202848)],
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
//------------------------------------------------------------------------------
                        Container(
                          margin: EdgeInsets.only(bottom: 40.h),
                          child: OutlinedButton(
                            onPressed: _isButtonDisabled
                                ? null
                                : () {
                                    if (_controllerQuiz.checkAnswer(
                                        _controllerQuiz
                                            .returnTextAnswerA(_myQuestions),
                                        _myQuestions)) {
                                      playSoundRightAnswer();
                                      setState(() {
                                        _isButtonDisabled = true;

                                        iconButton = Icons.done;
                                        _colorButtonA = Colors.green;
                                        _colorIconButtonA = Colors.green;
                                      });
                                      Future.delayed(
                                          const Duration(milliseconds: 500),
                                          () async {
                                        setState(() {
                                          _buildVideo = false;
                                        });
                                        await Future.delayed(
                                            Duration(milliseconds: 100));
                                        setState(() {
                                          if (counterQuestions ==
                                              _myQuestions.length) {
                                            _switchToWinner();
                                          } else {
                                            _controllerQuiz.numberOfQuestions++;
                                          }
                                          _colorIconButtonA =
                                              Colors.transparent;
                                          _colorButtonA = Colors.white;
                                          //mysound  onde posso fazer stop

                                          _buildVideo = true;
                                          _isButtonDisabled = false;
                                        });
                                      });
                                    } else {
                                      playSoundWrongAnswer();
                                      setState(() {
                                        _isButtonDisabled = true;
                                        iconButton = Icons.close;
                                        _colorButtonA = Colors.red;
                                        _colorIconButtonA = Colors.red;
                                      });
                                      Future.delayed(
                                          const Duration(milliseconds: 500),
                                          () {
                                        _switchToFailed();
                                      });
                                    }
                                  },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _controllerQuiz
                                      .returnTextAnswerA(_myQuestions),
                                  style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      color: _colorButtonA,
                                      fontSize: 16.sp),
                                ),
                                Container(
                                  height: 26.h,
                                  width: 26.w,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: _colorButtonA),
                                  ),
                                  child: Icon(
                                    iconButton,
                                    size: 16.sp,
                                    color: _colorIconButtonA,
                                  ),
                                )
                              ],
                            ),
                            style: OutlinedButton.styleFrom(
                              elevation: 7,
                              primary: Colors.white,
                              backgroundColor: Color(0xff202848),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              side: BorderSide(color: _colorButtonA),
                              padding: EdgeInsets.all(8),
                            ),
                          ),
                        ),
//------------------------------------------------------------------------------
                        Container(
                          margin: EdgeInsets.only(bottom: 40.h),
                          child: OutlinedButton(
                            onPressed: _isButtonDisabled
                                ? null
                                : () {
                                    if (_controllerQuiz.checkAnswer(
                                        _controllerQuiz
                                            .returnTextAnswerB(_myQuestions),
                                        _myQuestions)) {
                                      playSoundRightAnswer();
                                      setState(() {
                                        _isButtonDisabled = true;

                                        iconButton = Icons.done;
                                        _colorButtonB = Colors.green;
                                        _colorIconButtonB = Colors.green;
                                      });
                                      Future.delayed(
                                          const Duration(milliseconds: 500),
                                          () async {
                                        setState(() {
                                          _buildVideo = false;
                                        });
                                        await Future.delayed(
                                            Duration(milliseconds: 100));
                                        setState(() {
                                          if (counterQuestions ==
                                              _myQuestions.length) {
                                            _switchToWinner();
                                          } else {
                                            _controllerQuiz.numberOfQuestions++;
                                          }
                                          _colorIconButtonB =
                                              Colors.transparent;
                                          _colorButtonB = Colors.white;
                                          //mysound  onde posso fazer stop

                                          _buildVideo = true;
                                          _isButtonDisabled = false;
                                        });
                                      });
                                    } else {
                                      playSoundWrongAnswer();
                                      setState(() {
                                        _isButtonDisabled = true;
                                        iconButton = Icons.close;
                                        _colorButtonB = Colors.red;
                                        _colorIconButtonB = Colors.red;
                                      });
                                      Future.delayed(
                                          const Duration(milliseconds: 500),
                                          () {
                                        _switchToFailed();
                                      });
                                    }
                                  },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _controllerQuiz
                                      .returnTextAnswerB(_myQuestions),
                                  style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      color: _colorButtonB,
                                      fontSize: 16.sp),
                                ),
                                Container(
                                  height: 26.h,
                                  width: 26.w,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: _colorButtonB),
                                  ),
                                  child: Icon(
                                    iconButton,
                                    size: 16.sp,
                                    color: _colorIconButtonB,
                                  ),
                                )
                              ],
                            ),
                            style: OutlinedButton.styleFrom(
                              elevation: 7,
                              primary: Colors.white,
                              backgroundColor: Color(0xff202848),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              side: BorderSide(color: _colorButtonB),
                              padding: EdgeInsets.all(8),
                            ),
                          ),
                        ),

//------------------------------------------------------------------------------
                        Container(
                          margin: EdgeInsets.only(bottom: 40.h),
                          child: OutlinedButton(
                            onPressed: _isButtonDisabled
                                ? null
                                : () {
                                    if (_controllerQuiz.checkAnswer(
                                        _controllerQuiz
                                            .returnTextAnswerC(_myQuestions),
                                        _myQuestions)) {
                                      playSoundRightAnswer();
                                      setState(() {
                                        _isButtonDisabled = true;
                                        iconButton = Icons.done;
                                        _colorButtonC = Colors.green;
                                        _colorIconButtonC = Colors.green;
                                      });
                                      Future.delayed(
                                          const Duration(milliseconds: 500),
                                          () async {
                                        setState(() {
                                          _buildVideo = false;
                                        });
                                        await Future.delayed(
                                            Duration(milliseconds: 100));
                                        setState(() {
                                          if (counterQuestions ==
                                              _myQuestions.length) {
                                            _switchToWinner();
                                          } else {
                                            _controllerQuiz.numberOfQuestions++;
                                          }
                                          _colorIconButtonC =
                                              Colors.transparent;
                                          _colorButtonC = Colors.white;
                                          //mysound  onde posso fazer stop

                                          _buildVideo = true;
                                          _isButtonDisabled = false;
                                        });
                                      });
                                    } else {
                                      playSoundWrongAnswer();
                                      setState(() {
                                        _isButtonDisabled = true;
                                        iconButton = Icons.close;
                                        _colorButtonC = Colors.red;
                                        _colorIconButtonC = Colors.red;
                                      });
                                      Future.delayed(
                                          const Duration(milliseconds: 500),
                                          () {
                                        _switchToFailed();
                                      });
                                    }
                                  },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _controllerQuiz
                                      .returnTextAnswerC(_myQuestions),
                                  style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      color: _colorButtonC,
                                      fontSize: 16.sp),
                                ),
                                Container(
                                  height: 26.h,
                                  width: 26.w,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: _colorButtonC),
                                  ),
                                  child: Icon(
                                    iconButton,
                                    size: 16.sp,
                                    color: _colorIconButtonC,
                                  ),
                                )
                              ],
                            ),
                            style: OutlinedButton.styleFrom(
                              elevation: 7,
                              primary: Colors.white,
                              backgroundColor: Color(0xff202848),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              side: BorderSide(color: _colorButtonC),
                              padding: EdgeInsets.all(8),
                            ),
                          ),
                        ),
//------------------------------------------------------------------------------
                        Container(
                          margin: EdgeInsets.only(bottom: 40.h),
                          child: OutlinedButton(
                            onPressed: _isButtonDisabled
                                ? null
                                : () {
                                    if (_controllerQuiz.checkAnswer(
                                        _controllerQuiz
                                            .returnTextAnswerD(_myQuestions),
                                        _myQuestions)) {
                                      playSoundRightAnswer();
                                      setState(() {
                                        _isButtonDisabled = true;
                                        iconButton = Icons.done;
                                        _colorButtonD = Colors.green;
                                        _colorIconButtonD = Colors.green;
                                      });
                                      Future.delayed(
                                          const Duration(milliseconds: 500),
                                          () async {
                                        setState(() {
                                          _buildVideo = false;
                                        });
                                        await Future.delayed(
                                            Duration(milliseconds: 100));
                                        setState(() {
                                          if (counterQuestions ==
                                              _myQuestions.length) {
                                            _switchToWinner();
                                          } else {
                                            _controllerQuiz.numberOfQuestions++;
                                          }
                                          _colorIconButtonD =
                                              Colors.transparent;
                                          _colorButtonD = Colors.white;
                                          //mysound  onde posso fazer stop

                                          _buildVideo = true;
                                          _isButtonDisabled = false;
                                        });
                                      });
                                    } else {
                                      playSoundWrongAnswer();
                                      setState(() {
                                        _isButtonDisabled = true;
                                        iconButton = Icons.close;
                                        _colorButtonD = Colors.red;
                                        _colorIconButtonD = Colors.red;
                                      });
                                      Future.delayed(
                                          const Duration(milliseconds: 500),
                                          () {
                                        _switchToFailed();
                                      });
                                    }
                                  },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _controllerQuiz
                                      .returnTextAnswerD(_myQuestions),
                                  style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      color: _colorButtonD,
                                      fontSize: 16.sp),
                                ),
                                Container(
                                  height: 26.h,
                                  width: 26.w,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: _colorButtonD),
                                  ),
                                  child: Icon(
                                    iconButton,
                                    size: 16.sp,
                                    color: _colorIconButtonD,
                                  ),
                                )
                              ],
                            ),
                            style: OutlinedButton.styleFrom(
                              elevation: 7,
                              primary: Colors.white,
                              backgroundColor: Color(0xff202848),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              side: BorderSide(color: _colorButtonD),
                              padding: EdgeInsets.all(8),
                            ),
                          ),
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
