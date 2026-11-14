import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_ui/material_ui.dart';

/// Transições que existiam como preset no flutter_modular 6
/// (`TransitionType.rightToLeft` / `downToUp`) e foram removidas na v7.
abstract final class AppTransitions {
  static final rightToLeft = _slide(const Offset(1, 0));
  static final downToUp = _slide(const Offset(0, 1));

  static CustomTransition _slide(Offset begin) => CustomTransition(
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            SlideTransition(
          position: Tween(begin: begin, end: Offset.zero)
              .chain(CurveTween(curve: Curves.easeInOut))
              .animate(animation),
          child: child,
        ),
      );
}
