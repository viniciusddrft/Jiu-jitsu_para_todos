import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiu_jitsu_para_todos/src/views/shared/appbar_gradient/appbar_gradient.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WinnerInQuiz extends StatefulWidget {
  final String difficultyname;
  WinnerInQuiz({this.difficultyname});
  @override
  _WinnerInQuizState createState() => _WinnerInQuizState();
}

class _WinnerInQuizState extends State<WinnerInQuiz> {
  String difficultyname;
  @override
  void initState() {
    difficultyname = widget.difficultyname;
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
        title: Text('OSS!!!', style: TextStyle(fontFamily: 'YatraOne')),
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
                'Parabéns Você venceu na dificuldade $difficultyname',
                style: TextStyle(fontSize: 20.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
