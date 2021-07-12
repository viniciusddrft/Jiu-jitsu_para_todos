import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';

class ResultQuiz extends StatefulWidget {
  final int score;
  final String difficultyName;
  final int totalQuestions;
  ResultQuiz(
      {required this.score,
      required this.difficultyName,
      required this.totalQuestions});
  @override
  _ResultQuizState createState() => _ResultQuizState();
}

class _ResultQuizState extends State<ResultQuiz> {
  late String _iconPath;
  late String _textShowResult;
  late String _textMessage;
  late String _scorePercentageText;
  late double _scorePercentage;

  @override
  void initState() {
    _scorePercentage = widget.score / widget.totalQuestions;
    _scorePercentageText = (_scorePercentage * 100).toStringAsPrecision(2);
    if (_scorePercentage == 1.0) {
      _scorePercentageText = '100';
      _iconPath = 'assets/quiz/iconsresultquiz/victory.png';
      _textMessage = 'text_message_quiz_very_well'.tr();
    } else if (_scorePercentage >= 0.75 && _scorePercentage < 1.0) {
      _iconPath = 'assets/quiz/iconsresultquiz/reading-book.png';
      _textMessage = 'text_message_quiz_almost'.tr();
    } else {
      _iconPath = 'assets/quiz/iconsresultquiz/sad.png';
      _textMessage = 'text_message_quiz_sad'.tr();
    }

    if (widget.difficultyName == 'text_difficultyname_white_belt'.tr()) {
      _textShowResult = 'text_result_quiz_white_belt'.tr();
    } else if (widget.difficultyName == 'text_difficultyname_blue_belt'.tr()) {
      _textShowResult = 'text_result_quiz_blue_belt'.tr();
    } else if (widget.difficultyName == 'text_difficultyname_black_belt'.tr()) {
      _textShowResult = 'text_result_quiz_black_belt'.tr();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: AppColors.background,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              _iconPath,
              height: 100.h,
              width: 100.w,
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 15),
            Text(
              _textMessage,
              style: TextStyle(fontSize: 20.sp),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 15),
            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              child: Center(
                child: Text(
                  _textShowResult,
                  style: TextStyle(fontSize: 20.sp),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 10),
            Container(
              height: 150,
              width: 150,
              child: Stack(
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    child: CircularProgressIndicator(
                        strokeWidth: 7,
                        value: _scorePercentage,
                        backgroundColor: Color(0xff313959),
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.green)),
                  ),
                  Center(
                    child: Text(
                      _scorePercentageText + '%',
                      style: TextStyle(fontSize: 30.sp),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
