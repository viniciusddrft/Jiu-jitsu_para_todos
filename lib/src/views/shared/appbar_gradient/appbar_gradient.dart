import 'package:flutter/material.dart';

class AppBarGradient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[Color(0xff1b2c57), Colors.indigo],
            tileMode: TileMode.clamp),
      ),
    );
  }
}
