import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/modules/fightmarker/view/components/components/clock_widget.dart';
import 'package:jiu_jitsu_para_todos/src/modules/fightmarker/view/components/components/scoreboard_widget.dart';

class BodyFightMarker extends StatefulWidget {
  BodyFightMarker();
  @override
  _BodyFightMarkerState createState() => _BodyFightMarkerState();
}

class _BodyFightMarkerState extends State<BodyFightMarker> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Scoreboard(),
            SizedBox(
              width: MediaQuery.of(context).size.width / 20,
            ),
            Clock(),
            SizedBox(
              width: MediaQuery.of(context).size.width / 20,
            ),
            Scoreboard(),
          ],
        ),
      ),
    );
  }
}
