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
  final String difficultyname;
  QuizQuestions({@required this.difficulty, @required this.difficultyname})
      : assert(['easy', 'medium', 'hard'].contains(difficulty) &&
            [
              'text_difficultyname_white_belt'.tr(),
              'text_difficultyname_blue_belt'.tr(),
              'text_difficultyname_black_belt'.tr()
            ].contains(difficultyname));

  @override
  _QuizQuestionsState createState() => _QuizQuestionsState();
}

class _QuizQuestionsState extends State<QuizQuestions> {
  //quiz
  var _controllerQuiz = ControllerQuiz();
  var _myquestions;
  var _difficultyname;
  //disablebutton
  bool _isButtonDisabled = false;
  //build video
  bool _buildVideo = true;
  //icon button
  var iconButton = Icons.done;
  //song buttons
  final _playerrightanswer = AudioPlayer();
  final _playerwronganswer = AudioPlayer();
  // randomness for ads
  final _random = Random();
  var _num;
  // colors buttons
  var _colorbottonA = Colors.white;
  var _coloriconbottonA = Colors.transparent;
  var _colorbottonB = Colors.white;
  var _coloriconbottonB = Colors.transparent;
  var _colorbottonC = Colors.white;
  var _coloriconbottonC = Colors.transparent;
  var _colorbottonD = Colors.white;
  var _coloriconbottonD = Colors.transparent;

  @override
  void didChangeDependencies() {
    _myquestions = _controllerQuiz.choice(widget.difficulty);
    super.didChangeDependencies();
    _difficultyname = widget.difficultyname;
  }

  @override
  void dispose() {
    _playerrightanswer.dispose();
    _playerwronganswer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    int counterquestions = _controllerQuiz.numberquestions + 1;
    int totalnumberofquestions = _myquestions.length;
//------------------------------------------------------------------------------
    void playSoundRightAnswer() async {
      await _playerrightanswer.setAsset('assets/music/right_answer.mp3');
      _playerrightanswer.play();
    }

//------------------------------------------------------------------------------
    void playSoundWrongAnswer() async {
      await _playerwronganswer.setAsset('assets/music/wrong_answer.mp3');
      _playerwronganswer.play();
    }

//------------------------------------------------------------------------------
    void _switchToWinner() async {
      _num = _random.nextInt(10);
      if (_num >= 8) {
        Admob.showInterstitialAd();
      }
      await Navigator.of(context).pushReplacement(MyTransitionElasticOut(
          route: WinnerInQuiz(
            difficultyname: widget.difficultyname,
          ),
          duration: Duration(milliseconds: 500)));
    }

//------------------------------------------------------------------------------
    void _switchToFailed() async {
      _num = _random.nextInt(10);
      if (_num >= 2) {
        Admob.showInterstitialAd();
      }
      await Navigator.of(context).pushReplacement(MyTransitionElasticOut(
          route: FailedInQuiz(
            difficultyname: widget.difficultyname,
            score: counterquestions - 1,
            totalQuestions: totalnumberofquestions,
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
                'Quiz $_difficultyname',
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
                    ' $counterquestions/$totalnumberofquestions',
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
                _controllerQuiz.textquestionreturn(_myquestions),
                style: TextStyle(
                    fontFamily: 'Ubuntu', fontSize: 18.sp, color: Colors.white),
              ),
            ),
            returnImageOrVideoOfQuiz(
                _controllerQuiz, _myquestions, _buildVideo),
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
                                    if (_controllerQuiz.checkanswer(
                                        _controllerQuiz
                                            .returntextanswerA(_myquestions),
                                        _myquestions)) {
                                      playSoundRightAnswer();
                                      setState(() {
                                        _isButtonDisabled = true;

                                        iconButton = Icons.done;
                                        _colorbottonA = Colors.green;
                                        _coloriconbottonA = Colors.green;
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
                                          if (counterquestions ==
                                              _myquestions.length) {
                                            _switchToWinner();
                                          } else {
                                            _controllerQuiz.numberquestions++;
                                          }
                                          _coloriconbottonA =
                                              Colors.transparent;
                                          _colorbottonA = Colors.white;
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
                                        _colorbottonA = Colors.red;
                                        _coloriconbottonA = Colors.red;
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
                                      .returntextanswerA(_myquestions),
                                  style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      color: _colorbottonA,
                                      fontSize: 16.sp),
                                ),
                                Container(
                                  height: 26.h,
                                  width: 26.w,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: _colorbottonA),
                                  ),
                                  child: Icon(
                                    iconButton,
                                    size: 16.sp,
                                    color: _coloriconbottonA,
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
                              side: BorderSide(color: _colorbottonA),
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
                                    if (_controllerQuiz.checkanswer(
                                        _controllerQuiz
                                            .returntextanswerB(_myquestions),
                                        _myquestions)) {
                                      playSoundRightAnswer();
                                      setState(() {
                                        _isButtonDisabled = true;

                                        iconButton = Icons.done;
                                        _colorbottonB = Colors.green;
                                        _coloriconbottonB = Colors.green;
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
                                          if (counterquestions ==
                                              _myquestions.length) {
                                            _switchToWinner();
                                          } else {
                                            _controllerQuiz.numberquestions++;
                                          }
                                          _coloriconbottonB =
                                              Colors.transparent;
                                          _colorbottonB = Colors.white;
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
                                        _colorbottonB = Colors.red;
                                        _coloriconbottonB = Colors.red;
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
                                      .returntextanswerB(_myquestions),
                                  style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      color: _colorbottonB,
                                      fontSize: 16.sp),
                                ),
                                Container(
                                  height: 26.h,
                                  width: 26.w,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: _colorbottonB),
                                  ),
                                  child: Icon(
                                    iconButton,
                                    size: 16.sp,
                                    color: _coloriconbottonB,
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
                              side: BorderSide(color: _colorbottonB),
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
                                    if (_controllerQuiz.checkanswer(
                                        _controllerQuiz
                                            .returntextanswerC(_myquestions),
                                        _myquestions)) {
                                      playSoundRightAnswer();
                                      setState(() {
                                        _isButtonDisabled = true;
                                        iconButton = Icons.done;
                                        _colorbottonC = Colors.green;
                                        _coloriconbottonC = Colors.green;
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
                                          if (counterquestions ==
                                              _myquestions.length) {
                                            _switchToWinner();
                                          } else {
                                            _controllerQuiz.numberquestions++;
                                          }
                                          _coloriconbottonC =
                                              Colors.transparent;
                                          _colorbottonC = Colors.white;
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
                                        _colorbottonC = Colors.red;
                                        _coloriconbottonC = Colors.red;
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
                                      .returntextanswerC(_myquestions),
                                  style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      color: _colorbottonC,
                                      fontSize: 16.sp),
                                ),
                                Container(
                                  height: 26.h,
                                  width: 26.w,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: _colorbottonC),
                                  ),
                                  child: Icon(
                                    iconButton,
                                    size: 16.sp,
                                    color: _coloriconbottonC,
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
                              side: BorderSide(color: _colorbottonC),
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
                                    if (_controllerQuiz.checkanswer(
                                        _controllerQuiz
                                            .returntextanswerD(_myquestions),
                                        _myquestions)) {
                                      playSoundRightAnswer();
                                      setState(() {
                                        _isButtonDisabled = true;
                                        iconButton = Icons.done;
                                        _colorbottonD = Colors.green;
                                        _coloriconbottonD = Colors.green;
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
                                          if (counterquestions ==
                                              _myquestions.length) {
                                            _switchToWinner();
                                          } else {
                                            _controllerQuiz.numberquestions++;
                                          }
                                          _coloriconbottonD =
                                              Colors.transparent;
                                          _colorbottonD = Colors.white;
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
                                        _colorbottonD = Colors.red;
                                        _coloriconbottonD = Colors.red;
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
                                      .returntextanswerD(_myquestions),
                                  style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      color: _colorbottonD,
                                      fontSize: 16.sp),
                                ),
                                Container(
                                  height: 26.h,
                                  width: 26.w,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: _colorbottonD),
                                  ),
                                  child: Icon(
                                    iconButton,
                                    size: 16.sp,
                                    color: _coloriconbottonD,
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
                              side: BorderSide(color: _colorbottonD),
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
