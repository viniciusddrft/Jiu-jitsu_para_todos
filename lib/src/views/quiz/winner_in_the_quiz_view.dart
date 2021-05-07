import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiu_jitsu_para_todos/src/views/shared/appbar_gradient/appbar_gradient.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WinnerInQuiz extends StatefulWidget {
  final String difficultyname;
  WinnerInQuiz({@required this.difficultyname});
  @override
  _WinnerInQuizState createState() => _WinnerInQuizState();
}

class _WinnerInQuizState extends State<WinnerInQuiz> {
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
                'Parabens você conseguiu vencer a dificuldade ${widget.difficultyname}!!!',
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
                        value: 1,
                        backgroundColor: Color(0xff313959),
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.green)),
                  ),
                  Center(
                    child: Text(
                      '100%',
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
