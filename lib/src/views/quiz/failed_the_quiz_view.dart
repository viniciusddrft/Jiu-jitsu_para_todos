import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiu_jitsu_para_todos/src/views/shared/appbar_gradient/appbar_gradient.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FailedInQuiz extends StatefulWidget {
  final int score;
  final String difficultyname;
  FailedInQuiz({this.score, this.difficultyname});
  @override
  _FailedInQuizState createState() => _FailedInQuizState();
}

class _FailedInQuizState extends State<FailedInQuiz> {
  String difficultyname;
  int score;
  @override
  void initState() {
    difficultyname = widget.difficultyname;
    score = widget.score - 1;
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
                'Você acertou $score na dificuldade $difficultyname ',
                style: TextStyle(fontSize: 20.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
