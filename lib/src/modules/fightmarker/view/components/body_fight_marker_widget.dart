import 'package:flutter/material.dart';

import 'components/clock_widget.dart';
import 'components/scoreboard_widget.dart';

class BodyFightMarker extends StatefulWidget {
  const BodyFightMarker({super.key});
  @override
  State<BodyFightMarker> createState() => _BodyFightMarkerState();
}

class _BodyFightMarkerState extends State<BodyFightMarker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Flexible(
          flex: 2,
          child: Scoreboard(),
        ),
        Flexible(
          child: Clock(),
        ),
        Flexible(
          flex: 2,
          child: Scoreboard(),
        ),
      ],
    );
  }
}
