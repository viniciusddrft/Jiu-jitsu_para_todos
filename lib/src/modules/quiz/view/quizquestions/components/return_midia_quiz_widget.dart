import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/controller/quiz_controller.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/view/quizquestions/components/video_quiz_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget returnImageOrVideoOfQuiz(
    ControllerQuiz _controllerQuiz, var _myquestions, bool _buildVideo) {
  if (_controllerQuiz.existImage(_myquestions)) {
    return Padding(
      padding:
          EdgeInsets.only(right: 30.w, left: 30.w, top: 10.h, bottom: 10.h),
      child: Center(
        child: Container(
          width: 350.w,
          height: 254.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            image: DecorationImage(
              image: AssetImage(_controllerQuiz.returnPathImage(_myquestions)),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  } else if (_controllerQuiz.existVideo(_myquestions)) {
    return _buildVideo
        ? VideoQuiz(videoPath: _controllerQuiz.returnPathVideo(_myquestions))
        : Container(
            height: 250.h,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
  } else {
    return Container();
  }
}
