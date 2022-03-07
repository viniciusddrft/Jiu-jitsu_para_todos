import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/shared/button_for_menu/button_for_menu.dart';

class ButtonOptionsRules extends ButtonForMenu {
  final String routeButton;

  const ButtonOptionsRules(
      {Key? key,
      required imageButton,
      required textButton,
      required this.routeButton})
      : super(key: key, imageButton: imageButton, textButton: textButton);

  @override
  _ButtonOptionsRulesState createState() => _ButtonOptionsRulesState();
}

class _ButtonOptionsRulesState extends State<ButtonOptionsRules> {
  void changeRoute() => Navigator.pushNamed(context, widget.routeButton);

  @override
  Widget build(BuildContext context) {
    return widget.makeButton(context, changeRoute: changeRoute);
  }
}
