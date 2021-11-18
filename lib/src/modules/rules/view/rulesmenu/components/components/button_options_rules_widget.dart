import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/shared/button_for_menu/button_for_menu.dart';

class ButtonOptionsRules extends ButtonForMenu {
  final String imageButtonOptionsRules;
  final String textButtonOptionsRules;
  final String routeButton;

  const ButtonOptionsRules(
      {Key? key,
      required this.imageButtonOptionsRules,
      required this.textButtonOptionsRules,
      required this.routeButton})
      : super(
            key: key,
            imageButton: imageButtonOptionsRules,
            textButton: textButtonOptionsRules);

  @override
  Widget build(BuildContext context) {
    void changeRoute() => Navigator.pushNamed(context, routeButton);

    return makeButton(changeRoute);
  }
}
