import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/modules/fightmarker/view/fight_marker_view.dart';
import 'package:jiu_jitsu_para_todos/src/shared/animated_page_route_builder/my_transition_elatic_out.dart';
import 'package:jiu_jitsu_para_todos/src/shared/button_for_menu/button_for_menu.dart';

class ButtonOptionsHome extends ButtonForMenu {
  final String imageButton;
  final String textButton;
  final Widget routeButton;
  /*added because for this route it generates a bug if the routeButton variable is used,
  in this only case it needs to be hard code in line 28*/
  final bool isFightMakerView;
  const ButtonOptionsHome({
    required this.imageButton,
    required this.textButton,
    required this.routeButton,
    this.isFightMakerView = false,
  }) : super(
          imageButton: imageButton,
          textButton: textButton,
        );

  @override
  Widget build(BuildContext context) {
    void changeRoute() {
      if (isFightMakerView)
        Navigator.of(context)
            .push(MaterialPageRoute(
                builder: (BuildContext context) => FightMakerView()))
            .then((_) => Navigator.of(context)
                .pushReplacementNamed('/home')); //routeButton

      else
        Navigator.of(context).push(MyTransitionElasticOut(
            route: routeButton, duration: Duration(milliseconds: 500)));
    }

    return makeButton(changeRoute);
  }
}
