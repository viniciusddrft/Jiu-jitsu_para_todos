import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class Scoreboard extends StatefulWidget {
  @override
  _ScoreboardState createState() => _ScoreboardState();
}

class _ScoreboardState extends State<Scoreboard> {
  int _fighterPoints = 0;
  int _punishmentsOfTheFighter = 0;
  int _advantagesOfTheFighter = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('$_fighterPoints',
              style: TextStyle(fontSize: 60.sp, fontFamily: 'YatraOne')),
          SizedBox(width: MediaQuery.of(context).size.width / 35),
          Text('$_advantagesOfTheFighter',
              style: TextStyle(
                  fontSize: 60.sp,
                  color: Colors.yellow,
                  fontFamily: 'YatraOne')),
          SizedBox(width: MediaQuery.of(context).size.width / 35),
          Text('$_punishmentsOfTheFighter',
              style: TextStyle(
                  fontSize: 60.sp, color: Colors.red, fontFamily: 'YatraOne')),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
              iconSize: 60.sp,
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  _fighterPoints = _fighterPoints + 2;
                });
              }),
          SizedBox(width: MediaQuery.of(context).size.width / 70),
          Text(
            '2',
            style: TextStyle(fontSize: 60.sp, fontFamily: 'YatraOne'),
          ),
          SizedBox(width: MediaQuery.of(context).size.width / 70),
          IconButton(
              iconSize: 60.sp,
              icon: Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  if (_fighterPoints >= 2) {
                    _fighterPoints = _fighterPoints - 2;
                  }
                });
              }),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
              iconSize: 60.sp,
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  _fighterPoints = _fighterPoints + 3;
                });
              }),
          SizedBox(width: MediaQuery.of(context).size.width / 70),
          Text(
            '3',
            style: TextStyle(fontSize: 60.sp, fontFamily: 'YatraOne'),
          ),
          SizedBox(width: MediaQuery.of(context).size.width / 70),
          IconButton(
              iconSize: 60.sp,
              icon: Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  if (_fighterPoints >= 3) {
                    _fighterPoints = _fighterPoints - 3;
                  }
                });
              }),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
              iconSize: 60.sp,
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  _fighterPoints = _fighterPoints + 4;
                });
              }),
          SizedBox(width: MediaQuery.of(context).size.width / 70),
          Text('4', style: TextStyle(fontSize: 60.sp, fontFamily: 'YatraOne')),
          SizedBox(width: MediaQuery.of(context).size.width / 70),
          IconButton(
              iconSize: 60.sp,
              icon: Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  if (_fighterPoints >= 4) {
                    _fighterPoints = _fighterPoints - 4;
                  }
                });
              }),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
              iconSize: 60.sp,
              color: Colors.yellow,
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  _advantagesOfTheFighter++;
                });
              }),
          SizedBox(width: MediaQuery.of(context).size.width / 70),
          Text(
            'text_abbreviated_advantage'.tr(),
            style: TextStyle(
                fontSize: 60.sp, color: Colors.yellow, fontFamily: 'YatraOne'),
          ),
          SizedBox(width: MediaQuery.of(context).size.width / 70),
          IconButton(
              iconSize: 60.sp,
              color: Colors.yellow,
              icon: Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  if (_advantagesOfTheFighter >= 1) {
                    _advantagesOfTheFighter--;
                  }
                });
              }),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
              iconSize: 60.sp,
              color: Colors.red,
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  _punishmentsOfTheFighter++;
                });
              }),
          SizedBox(width: MediaQuery.of(context).size.width / 70),
          Text(
            'text_abbreviated_punishment'.tr(),
            style: TextStyle(
                fontSize: 60.sp, color: Colors.red, fontFamily: 'YatraOne'),
          ),
          SizedBox(width: MediaQuery.of(context).size.width / 70),
          IconButton(
              iconSize: 50.sp,
              color: Colors.red,
              icon: Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  if (_punishmentsOfTheFighter >= 1) {
                    _punishmentsOfTheFighter--;
                  }
                });
              }),
        ]),
      ],
    );
  }
}
