import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class Scoreboard extends StatefulWidget {
  @override
  _ScoreboardState createState() => _ScoreboardState();
}

class _ScoreboardState extends State<Scoreboard> {
  int _fighterpoints = 0;
  int _punishmentsofthefighter = 0;
  int _advantagesofthefighter = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('$_fighterpoints',
              style: TextStyle(fontSize: 60.sp, fontFamily: 'YatraOne')),
          SizedBox(width: MediaQuery.of(context).size.width / 35),
          Text('$_advantagesofthefighter',
              style: TextStyle(
                  fontSize: 60.sp,
                  color: Colors.yellow,
                  fontFamily: 'YatraOne')),
          SizedBox(width: MediaQuery.of(context).size.width / 35),
          Text('$_punishmentsofthefighter',
              style: TextStyle(
                  fontSize: 60.sp, color: Colors.red, fontFamily: 'YatraOne')),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
              iconSize: 60.sp,
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  _fighterpoints = _fighterpoints + 2;
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
                  if (_fighterpoints >= 2) {
                    _fighterpoints = _fighterpoints - 2;
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
                  _fighterpoints = _fighterpoints + 3;
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
                  if (_fighterpoints >= 3) {
                    _fighterpoints = _fighterpoints - 3;
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
                  _fighterpoints = _fighterpoints + 4;
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
                  if (_fighterpoints >= 4) {
                    _fighterpoints = _fighterpoints - 4;
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
                  _advantagesofthefighter++;
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
                  if (_advantagesofthefighter >= 1) {
                    _advantagesofthefighter--;
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
                  _punishmentsofthefighter++;
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
                  if (_punishmentsofthefighter >= 1) {
                    _punishmentsofthefighter--;
                  }
                });
              }),
        ]),
      ],
    );
  }
}
