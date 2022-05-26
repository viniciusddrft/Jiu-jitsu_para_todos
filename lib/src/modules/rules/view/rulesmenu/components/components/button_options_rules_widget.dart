import 'package:flutter/material.dart';

import '../../../../../../shared/button_for_menu/button_for_menu.dart';

class ButtonOptionsRules extends ButtonForMenu {
  final String routeButton;

  const ButtonOptionsRules(
      {super.key,
      required super.imageButton,
      required super.textButton,
      required this.routeButton});

  @override
  State<ButtonOptionsRules> createState() => _ButtonOptionsRulesState();
}

class _ButtonOptionsRulesState extends State<ButtonOptionsRules> {
  void changeRoute() => Navigator.pushNamed(context, widget.routeButton);

  @override
  Widget build(BuildContext context) {
    return widget.makeButton(context, changeRoute: changeRoute);
  }
}
