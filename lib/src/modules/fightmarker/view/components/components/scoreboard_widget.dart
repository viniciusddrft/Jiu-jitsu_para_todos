import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Scoreboard extends StatefulWidget {
  const Scoreboard({Key? key}) : super(key: key);
  @override
  _ScoreboardState createState() => _ScoreboardState();
}

class _ScoreboardState extends State<Scoreboard> {
  int _fighterPoints = 0;
  int _punishmentsOfTheFighter = 0;
  int _advantagesOfTheFighter = 0;

  //this setState fixes the size of texts on this screen due to rotation
  @override
  void didChangeDependencies() {
    Future.delayed(Duration.zero, () => setState(() {}));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('$_fighterPoints',
              style: TextStyle(fontSize: 40.sp, fontFamily: 'YatraOne')),
          SizedBox(width: MediaQuery.of(context).size.width / 35),
          Text('$_advantagesOfTheFighter',
              style: TextStyle(
                  fontSize: 40.sp,
                  color: Colors.yellow,
                  fontFamily: 'YatraOne')),
          SizedBox(width: MediaQuery.of(context).size.width / 35),
          Text('$_punishmentsOfTheFighter',
              style: TextStyle(
                  fontSize: 40.sp, color: Colors.red, fontFamily: 'YatraOne')),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
            iconSize: 40.sp,
            icon: const Icon(Icons.add),
            onPressed: () => setState(() => _fighterPoints += 2),
          ),
          SizedBox(width: MediaQuery.of(context).size.width / 70),
          Text(
            '2',
            style: TextStyle(fontSize: 40.sp, fontFamily: 'YatraOne'),
          ),
          SizedBox(width: MediaQuery.of(context).size.width / 70),
          IconButton(
            iconSize: 40.sp,
            icon: const Icon(Icons.remove),
            onPressed: () => setState(() {
              if (_fighterPoints >= 2) _fighterPoints -= 2;
            }),
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
            iconSize: 40.sp,
            icon: const Icon(Icons.add),
            onPressed: () => setState(() => _fighterPoints += 3),
          ),
          SizedBox(width: MediaQuery.of(context).size.width / 70),
          Text(
            '3',
            style: TextStyle(fontSize: 40.sp, fontFamily: 'YatraOne'),
          ),
          SizedBox(width: MediaQuery.of(context).size.width / 70),
          IconButton(
            iconSize: 40.sp,
            icon: const Icon(Icons.remove),
            onPressed: () => setState(() {
              if (_fighterPoints >= 3) _fighterPoints -= 3;
            }),
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
            iconSize: 40.sp,
            icon: const Icon(Icons.add),
            onPressed: () => setState(() => _fighterPoints += 4),
          ),
          SizedBox(width: MediaQuery.of(context).size.width / 70),
          Text('4', style: TextStyle(fontSize: 40.sp, fontFamily: 'YatraOne')),
          SizedBox(width: MediaQuery.of(context).size.width / 70),
          IconButton(
            iconSize: 40.sp,
            icon: const Icon(Icons.remove),
            onPressed: () => setState(() {
              if (_fighterPoints >= 4) _fighterPoints -= 4;
            }),
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
            iconSize: 40.sp,
            color: Colors.yellow,
            icon: const Icon(Icons.add),
            onPressed: () => setState(() => _advantagesOfTheFighter++),
          ),
          SizedBox(width: MediaQuery.of(context).size.width / 70),
          Text(
            AppLocalizations.of(context)!.text_abbreviated_advantage,
            style: TextStyle(
                fontSize: 40.sp, color: Colors.yellow, fontFamily: 'YatraOne'),
          ),
          SizedBox(width: MediaQuery.of(context).size.width / 70),
          IconButton(
            iconSize: 40.sp,
            color: Colors.yellow,
            icon: const Icon(Icons.remove),
            onPressed: () => setState(() {
              if (_advantagesOfTheFighter >= 1) _advantagesOfTheFighter--;
            }),
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
            iconSize: 40.sp,
            color: Colors.red,
            icon: const Icon(Icons.add),
            onPressed: () => setState(() => _punishmentsOfTheFighter++),
          ),
          SizedBox(width: MediaQuery.of(context).size.width / 70),
          Text(
            AppLocalizations.of(context)!.text_abbreviated_punishment,
            style: TextStyle(
                fontSize: 40.sp, color: Colors.red, fontFamily: 'YatraOne'),
          ),
          SizedBox(width: MediaQuery.of(context).size.width / 70),
          IconButton(
            iconSize: 40.sp,
            color: Colors.red,
            icon: const Icon(Icons.remove),
            onPressed: () => setState(
              () {
                if (_punishmentsOfTheFighter >= 1) _punishmentsOfTheFighter--;
              },
            ),
          ),
        ]),
      ],
    );
  }
}
