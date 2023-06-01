import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiu_jitsu_para_todos/src/shared/models/quiz/questions_model.dart';

import '../../../../../shared/themes/app_colors.dart';

class ButtonQuizQuestions extends StatelessWidget {
  final void Function(String answer, String orderOfQuestions,
      List<QuestionModel> myQuestions) onPressed;
  final bool isButtonDisabled;
  final String answer, orderOfQuestions;
  final Color colorButton;
  final Color? colorIcon;
  final IconData? icon;
  final List<QuestionModel> myQuestions;
  ButtonQuizQuestions(
      {super.key,
      required this.onPressed,
      required this.isButtonDisabled,
      required this.answer,
      required this.orderOfQuestions,
      required this.colorButton,
      required this.myQuestions,
      this.colorIcon,
      this.icon})
      : assert(['A', 'B', 'C', 'D'].contains(orderOfQuestions));
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.05),
      child: OutlinedButton(
        onPressed: isButtonDisabled
            ? null
            : () => onPressed(answer, orderOfQuestions, myQuestions),
        style: OutlinedButton.styleFrom(
          elevation: 7,
          foregroundColor: colorButton,
          backgroundColor: AppColors.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          side: BorderSide(color: colorButton),
          padding: const EdgeInsets.all(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              answer,
              style: GoogleFonts.ubuntu(
                fontSize: 16,
                color: colorButton,
              ),
            ),
            Container(
              height: size.height * 0.03,
              width: size.height * 0.03,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: colorButton),
              ),
              child: Icon(
                (icon),
                size: 16,
                color: colorIcon,
              ),
            )
          ],
        ),
      ),
    );
  }
}
