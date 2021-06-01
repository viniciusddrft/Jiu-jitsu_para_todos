import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/views/quiz/quiz_questions_view.dart';
import 'package:jiu_jitsu_para_todos/src/views/shared/animated_page_route_builder/my_transition_elatic_out.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class ButtonOptionQuiz extends StatefulWidget {
  final String imageButton;
  final String textButton;
  final String difficulty;
  final String difficultyName;
  ButtonOptionQuiz(
      {required this.imageButton,
      required this.textButton,
      required this.difficulty,
      required this.difficultyName})
      : assert([
              'assets/images/iconsbutton/faixabranca.png',
              'assets/images/iconsbutton/faixaazul.png',
              'assets/images/iconsbutton/faixapreta.png'
            ].contains(imageButton) &&
            [
              'button_white_belt_level'.tr(),
              'button_blue_belt_level'.tr(),
              'button_black_belt_level'.tr()
            ].contains(textButton) &&
            ['easy', 'medium', 'hard'].contains(difficulty) &&
            [
              'text_difficultyname_white_belt'.tr(),
              'text_difficultyname_blue_belt'.tr(),
              'text_difficultyname_black_belt'.tr()
            ].contains(difficultyName));

  @override
  _ButtonOptionQuizState createState() => _ButtonOptionQuizState();
}

class _ButtonOptionQuizState extends State<ButtonOptionQuiz> {
  void _changeRoute() async {
    await Navigator.of(context).push(
      MyTransitionElasticOut(
        route: QuizQuestions(
          difficulty: widget.difficulty,
          difficultyName: widget.difficultyName,
        ),
        duration: Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final thumbnail = GestureDetector(
      onTap: _changeRoute,
      child: Container(
        alignment: FractionalOffset(0.0, 0.5),
        margin: EdgeInsets.only(
          left: 24.0.w,
        ),
        child: Image.asset(widget.imageButton, width: 100.w, height: 100.h),
      ),
    );

    final card = Container(
      width: MediaQuery.of(context).size.width / 1.6,
      height: MediaQuery.of(context).size.height / 7,
      margin: EdgeInsets.only(left: 72.0.w, right: 24.0.w),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black, blurRadius: 10.0, offset: Offset(0.0, 10.0))
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 7,
          padding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: _changeRoute,
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff202848), Colors.indigo],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(8.0)),
          child: Center(
            child: Text(
              widget.textButton,
              style: TextStyle(fontSize: 18.sp),
            ),
          ),
        ),
      ),
    );

    return Container(
      margin:
          EdgeInsets.only(top: 30.0.h, bottom: 8.0.h, left: 10.w, right: 10.w),
      child: Stack(
        children: [card, thumbnail],
      ),
    );
  }
}
