import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiu_jitsu_para_todos/src/shared/animated_page_route_builder/my_transition_from_left_to_right_animated.dart';
import 'package:jiu_jitsu_para_todos/src/modules/home/view/home_page_view.dart';
import 'package:easy_localization/easy_localization.dart';

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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
            'text_splash_screen_page'.tr(),
            style: TextStyle(fontFamily: 'YatraOne', fontSize: 30),
          ),
        ),
      ),
    );
  }
}
