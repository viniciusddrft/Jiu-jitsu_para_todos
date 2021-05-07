import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiu_jitsu_para_todos/src/views/shared/appbar_gradient/appbar_gradient.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FailedInQuiz extends StatefulWidget {
  final int score;
  final String difficultyname;
  final int totalQuestions;
  FailedInQuiz(
      {@required this.score,
      @required this.difficultyname,
      @required this.totalQuestions});
  @override
  _FailedInQuizState createState() => _FailedInQuizState();
}

class _FailedInQuizState extends State<FailedInQuiz> {
  double scorePercentage;
  String socrePercentageText;

  @override
  void initState() {
    scorePercentage = widget.score / widget.totalQuestions;
    socrePercentageText = (scorePercentage * 100).toStringAsPrecision(2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: AppBarGradient(),
        title:
            Text('Não foi dessa vez', style: TextStyle(fontFamily: 'YatraOne')),
      ),
      backgroundColor: Color(0xff202848),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.2,
              child: Text(
                'Sua pontuação no quiz ${widget.difficultyname} foi',
                style: TextStyle(fontSize: 20.sp),
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
                        value: scorePercentage,
                        backgroundColor: Color(0xff313959),
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.green)),
                  ),
                  Center(
                    child: Text(
                      socrePercentageText + '%',
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
