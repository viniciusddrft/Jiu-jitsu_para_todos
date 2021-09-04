import 'package:flutter/material.dart';

class AppBarGradient extends StatelessWidget {
  const AppBarGradient();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[Color(0xff1b2c57), Colors.indigo],
            tileMode: TileMode.clamp),
      ),
    );
  }
}
