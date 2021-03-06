import 'package:flutter/material.dart';

import '../../../../../shared/themes/app_colors.dart';

class ButtonQuizQuestions extends StatelessWidget {
  final void Function(String answer, String orderOfQuestions) onPressed;
  final bool isButtonDisabled;
  final String answer;
  final String orderOfQuestions;
  final Color colorButton;
  final Color? colorIcon;
  final IconData? icon;
  ButtonQuizQuestions(
      {super.key,
      required this.onPressed,
      required this.isButtonDisabled,
      required this.answer,
      required this.orderOfQuestions,
      required this.colorButton,
      this.colorIcon,
      this.icon})
      : assert(['A', 'B', 'C', 'D'].contains(orderOfQuestions));
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.05),
      child: OutlinedButton(
        onPressed:
            isButtonDisabled ? null : () => onPressed(answer, orderOfQuestions),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              answer,
              style: TextStyle(
                  fontFamily: 'Ubuntu', color: colorButton, fontSize: 16),
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
