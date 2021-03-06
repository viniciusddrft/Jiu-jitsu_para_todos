import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Scoreboard extends StatefulWidget {
  const Scoreboard({super.key});
  @override
  State<Scoreboard> createState() => _ScoreboardState();
}

class _ScoreboardState extends State<Scoreboard> {
  late final Size size = MediaQuery.of(context).size;
  final ValueNotifier<int> _fighterPoints = ValueNotifier<int>(0);
  final ValueNotifier<int> _punishmentsOfTheFighter = ValueNotifier<int>(0);
  final ValueNotifier<int> _advantagesOfTheFighter = ValueNotifier<int>(0);

  @override
  void dispose() {
    _fighterPoints.dispose();
    _punishmentsOfTheFighter.dispose();
    _advantagesOfTheFighter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ValueListenableBuilder(
            valueListenable: _fighterPoints,
            builder: (BuildContext context, int value, Widget? child) => Text(
              '${_fighterPoints.value}',
              style: const TextStyle(fontSize: 30, fontFamily: 'YatraOne'),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.033),
            child: ValueListenableBuilder(
              valueListenable: _advantagesOfTheFighter,
              builder: (BuildContext context, int value, Widget? child) => Text(
                '${_advantagesOfTheFighter.value}',
                style: const TextStyle(
                    fontSize: 30, color: Colors.yellow, fontFamily: 'YatraOne'),
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: _punishmentsOfTheFighter,
            builder: (BuildContext context, int value, Widget? child) => Text(
              '${_punishmentsOfTheFighter.value}',
              style: const TextStyle(
                  fontSize: 30, color: Colors.red, fontFamily: 'YatraOne'),
            ),
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
              iconSize: 30,
              icon: const Icon(Icons.add),
              onPressed: () => _fighterPoints.value += 2),
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
            onPressed: () =>
                (_fighterPoints.value >= 2) ? _fighterPoints.value -= 2 : null,
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
            iconSize: 30,
            icon: const Icon(Icons.add),
            onPressed: () => _fighterPoints.value += 3,
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
            onPressed: () =>
                (_fighterPoints.value >= 3) ? _fighterPoints.value -= 3 : null,
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
            iconSize: 30,
            icon: const Icon(Icons.add),
            onPressed: () => _fighterPoints.value += 4,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
            child: const Text('4',
                style: TextStyle(fontSize: 30, fontFamily: 'YatraOne')),
          ),
          IconButton(
              iconSize: 30,
              icon: const Icon(Icons.remove),
              onPressed: () => (_fighterPoints.value >= 4)
                  ? _fighterPoints.value -= 4
                  : null),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
            iconSize: 30,
            color: Colors.yellow,
            icon: const Icon(Icons.add),
            onPressed: () => _advantagesOfTheFighter.value++,
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
            onPressed: () => (_advantagesOfTheFighter.value >= 1)
                ? _advantagesOfTheFighter.value--
                : null,
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
            iconSize: 30,
            color: Colors.red,
            icon: const Icon(Icons.add),
            onPressed: () => _punishmentsOfTheFighter.value++,
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
            onPressed: () => (_punishmentsOfTheFighter.value >= 1)
                ? _punishmentsOfTheFighter.value--
                : null,
          ),
        ]),
      ],
    );
  }
}
