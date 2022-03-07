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
  _ButtonOptionsHistoryState createState() => _ButtonOptionsHistoryState();
}

class _ButtonOptionsHistoryState extends State<ButtonOptionsHistory> {
  void changeRoute() => Navigator.pushNamed(context, widget.routeButton);

  @override
  Widget build(BuildContext context) {
    return widget.makeButton(context, changeRoute: changeRoute);
  }
}
