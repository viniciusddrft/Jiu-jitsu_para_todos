import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Scoreboard extends StatefulWidget {
  const Scoreboard({super.key});
  @override
  State<Scoreboard> createState() => _ScoreboardState();
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
    final Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('$_fighterPoints',
              style: const TextStyle(fontSize: 30, fontFamily: 'YatraOne')),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
            child: Text(
              '$_advantagesOfTheFighter',
              style: const TextStyle(
                  fontSize: 30, color: Colors.yellow, fontFamily: 'YatraOne'),
            ),
          ),
          Text('$_punishmentsOfTheFighter',
              style: const TextStyle(
                  fontSize: 30, color: Colors.red, fontFamily: 'YatraOne')),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
            iconSize: 30,
            icon: const Icon(Icons.add),
            onPressed: () => setState(() => _fighterPoints += 2),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
            child: const Text(
              '2',
              style: TextStyle(fontSize: 30, fontFamily: 'YatraOne'),
            ),
          ),
          IconButton(
            iconSize: 30,
            icon: const Icon(Icons.remove),
            onPressed: () => setState(() {
              if (_fighterPoints >= 2) _fighterPoints -= 2;
            }),
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
            iconSize: 30,
            icon: const Icon(Icons.add),
            onPressed: () => setState(() => _fighterPoints += 3),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
            child: const Text(
              '3',
              style: TextStyle(fontSize: 30, fontFamily: 'YatraOne'),
            ),
          ),
          IconButton(
            iconSize: 30,
            icon: const Icon(Icons.remove),
            onPressed: () => setState(() {
              if (_fighterPoints >= 3) _fighterPoints -= 3;
            }),
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
            iconSize: 30,
            icon: const Icon(Icons.add),
            onPressed: () => setState(() => _fighterPoints += 4),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
            child: const Text('4',
                style: TextStyle(fontSize: 30, fontFamily: 'YatraOne')),
          ),
          IconButton(
            iconSize: 30,
            icon: const Icon(Icons.remove),
            onPressed: () => setState(() {
              if (_fighterPoints >= 4) _fighterPoints -= 4;
            }),
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
            iconSize: 30,
            color: Colors.yellow,
            icon: const Icon(Icons.add),
            onPressed: () => setState(() => _advantagesOfTheFighter++),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
            child: Text(
              AppLocalizations.of(context)!.text_abbreviated_advantage,
              style: const TextStyle(
                  fontSize: 30, color: Colors.yellow, fontFamily: 'YatraOne'),
            ),
          ),
          IconButton(
            iconSize: 30,
            color: Colors.yellow,
            icon: const Icon(Icons.remove),
            onPressed: () => setState(() {
              if (_advantagesOfTheFighter >= 1) _advantagesOfTheFighter--;
            }),
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
            iconSize: 30,
            color: Colors.red,
            icon: const Icon(Icons.add),
            onPressed: () => setState(() => _punishmentsOfTheFighter++),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
            child: Text(
              AppLocalizations.of(context)!.text_abbreviated_punishment,
              style: const TextStyle(
                  fontSize: 30, color: Colors.red, fontFamily: 'YatraOne'),
            ),
          ),
          IconButton(
            iconSize: 30,
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
