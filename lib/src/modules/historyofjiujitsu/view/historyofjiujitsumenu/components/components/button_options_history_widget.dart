import 'package:flutter/material.dart';

import '../../../../../../shared/button_for_menu/button_for_menu.dart';

class ButtonOptionsHistory extends ButtonForMenu {
  final String routeButton;
  const ButtonOptionsHistory(
      {required super.imageButton,
      required super.textButton,
      required this.routeButton,
      super.key});
  @override
  State<ButtonOptionsHistory> createState() => _ButtonOptionsHistoryState();
}

class _ButtonOptionsHistoryState extends State<ButtonOptionsHistory> {
  void changeRoute() => Navigator.pushNamed(context, widget.routeButton);

  @override
  void didChangeDependencies() {
    precacheImage(Image.asset(widget.imageButton).image, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return widget.makeButton(context, changeRoute: changeRoute);
  }
}
