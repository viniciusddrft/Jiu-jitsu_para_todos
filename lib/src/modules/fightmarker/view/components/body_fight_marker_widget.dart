import 'package:flutter/material.dart';

import 'components/clock_widget.dart';
import 'components/scoreboard_widget.dart';

class BodyFightMarker extends StatefulWidget {
  const BodyFightMarker({Key? key}) : super(key: key);
  @override
  State<BodyFightMarker> createState() => _BodyFightMarkerState();
}

class _BodyFightMarkerState extends State<BodyFightMarker> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: SizedBox(
        width: size.width,
        height: size.height * 0.78,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Scoreboard(),
            SizedBox(
              width: size.width * 0.05,
            ),
            const Clock(),
            SizedBox(
              width: size.width * 0.05,
            ),
            const Scoreboard(),
          ],
        ),
      ),
    );
  }
}
