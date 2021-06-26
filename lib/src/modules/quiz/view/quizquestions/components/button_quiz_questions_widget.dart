import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonQuizQuestions extends StatelessWidget {
  final Function(String answer, String orderOfQuestions) onpressed;
  final bool isButtonDisabled;
  final String answer;
  final String orderOfQuestions;
  final Color colorButton;
  final Color? colorIcon;
  final IconData? icon;
  ButtonQuizQuestions(
      {required this.onpressed,
      required this.isButtonDisabled,
      required this.answer,
      required this.orderOfQuestions,
      required this.colorButton,
      this.colorIcon,
      this.icon})
      : assert(['A', 'B', 'C', 'D'].contains(orderOfQuestions));
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 40.h),
      child: OutlinedButton(
        onPressed:
            isButtonDisabled ? null : () => onpressed(answer, orderOfQuestions),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              answer,
              style: TextStyle(
                  fontFamily: 'Ubuntu', color: colorButton, fontSize: 16.sp),
            ),
            Container(
              height: 26.h,
              width: 26.w,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: colorButton),
              ),
              child: Icon(
                (icon),
                size: 16.sp,
                color: colorIcon,
              ),
            )
          ],
        ),
        style: OutlinedButton.styleFrom(
          elevation: 7,
          primary: colorButton,
          backgroundColor: Color(0xff202848),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          side: BorderSide(color: colorButton),
          padding: EdgeInsets.all(8),
        ),
      ),
    );
  }
}
