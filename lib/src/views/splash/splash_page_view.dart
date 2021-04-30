import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/views/home/home_page_view.dart';
import 'package:jiu_jitsu_para_todos/src/views/shared/animated_page_route_builder/my_transition_from_left_to_right_animated.dart';

class SplashPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then(
      (value) async => await Navigator.of(context).pushReplacement(
        MyTransitionFromLeftToRightAnimated(
          route: HomePageView(),
          duration: Duration(milliseconds: 500),
        ),
      ),
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Color(0xff202848), Colors.indigo],
                tileMode: TileMode.clamp)),
        child: Center(
          child: Text(
            'Jiu-jitsu para todos',
            style: TextStyle(fontFamily: 'YatraOne', fontSize: 30),
          ),
        ),
      ),
    );
  }
}
