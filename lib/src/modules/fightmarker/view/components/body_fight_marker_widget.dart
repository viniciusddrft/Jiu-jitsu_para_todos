import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/modules/fightmarker/view/components/components/clock_widget.dart';
import 'package:jiu_jitsu_para_todos/src/modules/fightmarker/view/components/components/scoreboard_widget.dart';

class BodyFightMarker extends StatefulWidget {
  const BodyFightMarker({Key? key}) : super(key: key);
  @override
  _BodyFightMarkerState createState() => _BodyFightMarkerState();
}

class _BodyFightMarkerState extends State<BodyFightMarker> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: SizedBox(
        width: _size.width,
        height: _size.height * 0.78,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Scoreboard(),
            SizedBox(
              width: _size.width * 0.05,
            ),
            const Clock(),
            SizedBox(
              width: _size.width * 0.05,
            ),
            const Scoreboard(),
          ],
        ),
      ),
    );
  }
}
