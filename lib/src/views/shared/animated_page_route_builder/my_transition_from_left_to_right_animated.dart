import 'package:flutter/material.dart';

class MyTransitionFromLeftToRightAnimated extends PageRouteBuilder {
  final Widget route;
  final Duration duration;
  MyTransitionFromLeftToRightAnimated(
      {@required this.route, @required this.duration})
      : super(
          transitionDuration: duration,
          reverseTransitionDuration: duration,
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return route;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
}
