import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiu_jitsu_para_todos/src/views/fightmarker/components/body_fight_marker_widget.dart';
import 'package:jiu_jitsu_para_todos/src/views/shared/appbar_gradient/appbar_gradient.dart';

class FightMakerView extends StatefulWidget {
  @override
  _FightMakerViewState createState() => _FightMakerViewState();
}

class _FightMakerViewState extends State<FightMakerView> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: AppBarGradient(),
        title:
            Text('Marcador de luta', style: TextStyle(fontFamily: 'YatraOne')),
      ),
      backgroundColor: Color(0xff202848),
      body: BodyFightMarker(),
    );
  }
}