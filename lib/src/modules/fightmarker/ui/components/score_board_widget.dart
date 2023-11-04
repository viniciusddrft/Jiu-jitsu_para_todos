import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiu_jitsu_para_todos/src/modules/fightmarker/interector/scorreboard_interector.dart';

class Scoreboard extends StatefulWidget {
  const Scoreboard({super.key});
  @override
  State<Scoreboard> createState() => _ScoreboardState();
}

class _ScoreboardState extends State<Scoreboard> {
  final _scoreboardInterector = Modular.get<ScoreboardInterector>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: _scoreboardInterector,
          builder: (context, child) =>
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              '${_scoreboardInterector.fighterPoints}',
              style: GoogleFonts.yatraOne(fontSize: 30),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.033),
              child: Text(
                '${_scoreboardInterector.advantagesOfTheFighter}',
                style: GoogleFonts.yatraOne(fontSize: 30, color: Colors.yellow),
              ),
            ),
            Text(
              '${_scoreboardInterector.punishmentsOfTheFighter}',
              style: GoogleFonts.yatraOne(fontSize: 30, color: Colors.red),
            ),
          ]),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
              iconSize: 30,
              icon: const Icon(Icons.add),
              onPressed: () => _scoreboardInterector.addPoints(2)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
            child: Text(
              '2',
              style: GoogleFonts.yatraOne(fontSize: 30),
            ),
          ),
          IconButton(
            iconSize: 30,
            icon: const Icon(Icons.remove),
            onPressed: () => _scoreboardInterector.removePoints(2),
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
            iconSize: 30,
            icon: const Icon(Icons.add),
            onPressed: () => _scoreboardInterector.addPoints(3),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
            child: Text(
              '3',
              style: GoogleFonts.yatraOne(fontSize: 30),
            ),
          ),
          IconButton(
            iconSize: 30,
            icon: const Icon(Icons.remove),
            onPressed: () => _scoreboardInterector.removePoints(3),
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
            iconSize: 30,
            icon: const Icon(Icons.add),
            onPressed: () => _scoreboardInterector.addPoints(4),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
            child: Text('4', style: GoogleFonts.yatraOne(fontSize: 30)),
          ),
          IconButton(
              iconSize: 30,
              icon: const Icon(Icons.remove),
              onPressed: () => _scoreboardInterector.removePoints(4)),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
            iconSize: 30,
            color: Colors.yellow,
            icon: const Icon(Icons.add),
            onPressed: _scoreboardInterector.addAdvantages,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
            child: Text(
              AppLocalizations.of(context)!.text_abbreviated_advantage,
              style: GoogleFonts.yatraOne(fontSize: 30, color: Colors.yellow),
            ),
          ),
          IconButton(
            iconSize: 30,
            color: Colors.yellow,
            icon: const Icon(Icons.remove),
            onPressed: _scoreboardInterector.removeAdvantages,
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
            iconSize: 30,
            color: Colors.red,
            icon: const Icon(Icons.add),
            onPressed: _scoreboardInterector.addPunishments,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
            child: Text(
              AppLocalizations.of(context)!.text_abbreviated_punishment,
              style: GoogleFonts.yatraOne(fontSize: 30, color: Colors.red),
            ),
          ),
          IconButton(
            iconSize: 30,
            color: Colors.red,
            icon: const Icon(Icons.remove),
            onPressed: _scoreboardInterector.removePunishments,
          ),
        ]),
      ],
    );
  }

  @override
  void dispose() {
    _scoreboardInterector.dispose();
    super.dispose();
  }
}
