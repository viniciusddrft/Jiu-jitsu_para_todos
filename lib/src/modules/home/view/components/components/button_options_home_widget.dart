import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/shared/button_for_menu/button_for_menu.dart';

class ButtonOptionsHome extends ButtonForMenu {
  final String routeButton;
  /*added because for this route it generates a bug if the routeButton variable is used,
  in this only case it needs to be hard code in line 26*/
  final bool isFightMakerView;
  const ButtonOptionsHome(
      {required textButton,
      required imageButton,
      required this.routeButton,
      this.isFightMakerView = false,
      Key? key})
      : super(imageButton: imageButton, textButton: textButton, key: key);

  @override
  _ButtonOptionsHomeState createState() => _ButtonOptionsHomeState();
}

class _ButtonOptionsHomeState extends State<ButtonOptionsHome> {
  void changeRoute() => widget.isFightMakerView
      ? Navigator.pushNamed(context, widget.routeButton).then(
          (_) => Navigator.pushReplacementNamed(context, '/Home'),
        )
      : Navigator.pushNamed(context, widget.routeButton);

  @override
  Widget build(BuildContext context) {
    return widget.makeButton(context, changeRoute: changeRoute);
  }
}
