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

class QuestionsQuiz extends StatefulWidget {
  final String difficulty;
  final String difficultyname;
  QuestionsQuiz({@required this.difficulty, @required this.difficultyname})
      : assert(['easy', 'medium', 'hard'].contains(difficulty) &&
            ['Faixa Branca', 'Faixa Azul', 'Faixa Preta']
                .contains(difficultyname));

  @override
  _QuestionsQuizState createState() => _QuestionsQuizState();
}

class _QuestionsQuizState extends State<QuestionsQuiz> {
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
  var colorbottonA = Colors.white;
  var coloriconbottonA = Colors.transparent;
  var colorbottonB = Colors.white;
  var coloriconbottonB = Colors.transparent;
  var colorbottonC = Colors.white;
  var coloriconbottonC = Colors.transparent;
  var colorbottonD = Colors.white;
  var coloriconbottonD = Colors.transparent;

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
            score: counterquestions,
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
                'Questão $counterquestions/$totalnumberofquestions',
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
              padding: EdgeInsets.only(top: 30.h, left: 30.w, right: 30.w),
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
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      children: [
//------------------------------------------------------------------------------
                        Container(
                          margin: EdgeInsets.only(bottom: 40.w),
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
                                        colorbottonA = Colors.green;
                                        coloriconbottonA = Colors.green;
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
                                          coloriconbottonA = Colors.transparent;
                                          colorbottonA = Colors.white;
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
                                        colorbottonA = Colors.red;
                                        coloriconbottonA = Colors.red;
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
                                      color: colorbottonA,
                                      fontSize: 16.sp),
                                ),
                                Container(
                                  height: 26.h,
                                  width: 26.w,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: colorbottonA),
                                  ),
                                  child: Icon(
                                    iconButton,
                                    size: 16.sp,
                                    color: coloriconbottonA,
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
                              side: BorderSide(color: colorbottonA),
                              padding: EdgeInsets.all(8),
                            ),
                          ),
                        ),

//------------------------------------------------------------------------------
                        Container(
                          margin: EdgeInsets.only(bottom: 40.w),
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
                                        colorbottonB = Colors.green;
                                        coloriconbottonB = Colors.green;
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
                                          coloriconbottonB = Colors.transparent;
                                          colorbottonB = Colors.white;
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
                                        colorbottonB = Colors.red;
                                        coloriconbottonB = Colors.red;
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
                                      color: colorbottonB,
                                      fontSize: 16.sp),
                                ),
                                Container(
                                  height: 26.h,
                                  width: 26.w,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: colorbottonB),
                                  ),
                                  child: Icon(
                                    iconButton,
                                    size: 16.sp,
                                    color: coloriconbottonB,
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
                              side: BorderSide(color: colorbottonB),
                              padding: EdgeInsets.all(8),
                            ),
                          ),
                        ),

//------------------------------------------------------------------------------
                        Container(
                          margin: EdgeInsets.only(bottom: 40.w),
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
                                        colorbottonC = Colors.green;
                                        coloriconbottonC = Colors.green;
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
                                          coloriconbottonC = Colors.transparent;
                                          colorbottonC = Colors.white;
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
                                        colorbottonC = Colors.red;
                                        coloriconbottonC = Colors.red;
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
                                      color: colorbottonC,
                                      fontSize: 16.sp),
                                ),
                                Container(
                                  height: 26.h,
                                  width: 26.w,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: colorbottonC),
                                  ),
                                  child: Icon(
                                    iconButton,
                                    size: 16.sp,
                                    color: coloriconbottonC,
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
                              side: BorderSide(color: colorbottonC),
                              padding: EdgeInsets.all(8),
                            ),
                          ),
                        ),

//------------------------------------------------------------------------------
                        Container(
                          margin: EdgeInsets.only(bottom: 40.w),
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
                                        colorbottonD = Colors.green;
                                        coloriconbottonD = Colors.green;
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
                                          coloriconbottonD = Colors.transparent;
                                          colorbottonD = Colors.white;
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
                                        colorbottonD = Colors.red;
                                        coloriconbottonD = Colors.red;
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
                                      color: colorbottonD,
                                      fontSize: 16.sp),
                                ),
                                Container(
                                  height: 26.h,
                                  width: 26.w,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: colorbottonD),
                                  ),
                                  child: Icon(
                                    iconButton,
                                    size: 16.sp,
                                    color: coloriconbottonD,
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
                              side: BorderSide(color: colorbottonD),
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
