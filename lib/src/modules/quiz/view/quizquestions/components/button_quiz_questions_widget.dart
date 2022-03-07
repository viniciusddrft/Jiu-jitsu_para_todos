import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';

class ButtonQuizQuestions extends StatelessWidget {
  final void Function(String answer, String orderOfQuestions) onPressed;
  final bool isButtonDisabled;
  final String answer;
  final String orderOfQuestions;
  final Color colorButton;
  final Color? colorIcon;
  final IconData? icon;
  ButtonQuizQuestions(
      {Key? key,
      required this.onPressed,
      required this.isButtonDisabled,
      required this.answer,
      required this.orderOfQuestions,
      required this.colorButton,
      this.colorIcon,
      this.icon})
      : assert(['A', 'B', 'C', 'D'].contains(orderOfQuestions)),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(bottom: _size.height * 0.05),
      child: OutlinedButton(
        onPressed:
            isButtonDisabled ? null : () => onPressed(answer, orderOfQuestions),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              answer,
              style: TextStyle(
                  fontFamily: 'Ubuntu', color: colorButton, fontSize: 16),
            ),
            Container(
              height: _size.height * 0.03,
              width: _size.height * 0.03,
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
        style: OutlinedButton.styleFrom(
          elevation: 7,
          primary: colorButton,
          backgroundColor: AppColors.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          side: BorderSide(color: colorButton),
          padding: const EdgeInsets.all(8),
        ),
      ),
    );
  }
}
