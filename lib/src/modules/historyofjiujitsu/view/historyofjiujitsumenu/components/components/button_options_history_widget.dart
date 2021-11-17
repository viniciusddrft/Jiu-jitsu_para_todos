import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/shared/button_for_menu/button_for_menu.dart';

class ButtonOptionsHistory extends ButtonForMenu {
  final String imageButton;
  final String textButton;
  final String routeButton;
  const ButtonOptionsHistory(
      {required this.imageButton,
      required this.textButton,
      required this.routeButton})
      : super(imageButton: imageButton, textButton: textButton);

  @override
  Widget build(BuildContext context) {
    void changeRoute() => Navigator.pushNamed(context, routeButton);

    return makeButton(changeRoute);
  }
}
