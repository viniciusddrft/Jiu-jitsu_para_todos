import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/shared/button_for_menu/button_for_menu.dart';

class ButtonOptionsHistory extends ButtonForMenu {
  final String imageButtonOptionsHistory;
  final String textButtonOptionsHistory;
  final String routeButton;
  const ButtonOptionsHistory(
      {required this.imageButtonOptionsHistory,
      required this.textButtonOptionsHistory,
      required this.routeButton,
      Key? key})
      : super(
            imageButton: imageButtonOptionsHistory,
            textButton: textButtonOptionsHistory,
            key: key);

  @override
  Widget build(BuildContext context) {
    void changeRoute() => Navigator.pushNamed(context, routeButton);

    return makeButton(changeRoute);
  }
}
