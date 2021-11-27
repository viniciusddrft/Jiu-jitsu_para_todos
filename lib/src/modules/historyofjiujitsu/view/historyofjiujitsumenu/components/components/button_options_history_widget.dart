import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/shared/button_for_menu/button_for_menu.dart';

class ButtonOptionsHistory extends ButtonForMenu {
  final String routeButton;
  const ButtonOptionsHistory(
      {required imageButton,
      required textButton,
      required this.routeButton,
      Key? key})
      : super(imageButton: imageButton, textButton: textButton, key: key);

  @override
  Widget build(BuildContext context) {
    void changeRoute() => Navigator.pushNamed(context, routeButton);

    return makeButton(changeRoute);
  }
}
