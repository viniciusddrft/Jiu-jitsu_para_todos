import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiu_jitsu_para_todos/src/modules/fightmarker/interactor/scorreboard_interactor.dart';
import 'package:jiu_jitsu_para_todos/src/shared/l10n/app_localizations.dart';

class Scoreboard extends StatefulWidget {
  const Scoreboard({super.key});
  @override
  State<Scoreboard> createState() => _ScoreboardState();
}

class _ScoreboardState extends State<Scoreboard> {
  final _scoreboardInteractor = Modular.get<ScoreboardInteractor>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: _scoreboardInteractor,
          builder: (context, child) =>
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              '${_scoreboardInteractor.fighterPoints}',
              style: GoogleFonts.yatraOne(fontSize: 30),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.033),
              child: Text(
                '${_scoreboardInteractor.advantagesOfTheFighter}',
                style: GoogleFonts.yatraOne(fontSize: 30, color: Colors.yellow),
              ),
            ),
            Text(
              '${_scoreboardInteractor.punishmentsOfTheFighter}',
              style: GoogleFonts.yatraOne(fontSize: 30, color: Colors.red),
            ),
          ]),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
              iconSize: 30,
              icon: const Icon(Icons.add),
              onPressed: () => _scoreboardInteractor.addPoints(2)),
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
            onPressed: () => _scoreboardInteractor.removePoints(2),
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
            iconSize: 30,
            icon: const Icon(Icons.add),
            onPressed: () => _scoreboardInteractor.addPoints(3),
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
            onPressed: () => _scoreboardInteractor.removePoints(3),
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
            iconSize: 30,
            icon: const Icon(Icons.add),
            onPressed: () => _scoreboardInteractor.addPoints(4),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
            child: Text('4', style: GoogleFonts.yatraOne(fontSize: 30)),
          ),
          IconButton(
              iconSize: 30,
              icon: const Icon(Icons.remove),
              onPressed: () => _scoreboardInteractor.removePoints(4)),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
            iconSize: 30,
            color: Colors.yellow,
            icon: const Icon(Icons.add),
            onPressed: _scoreboardInteractor.addAdvantages,
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
            onPressed: _scoreboardInteractor.removeAdvantages,
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
            iconSize: 30,
            color: Colors.red,
            icon: const Icon(Icons.add),
            onPressed: _scoreboardInteractor.addPunishments,
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
            onPressed: _scoreboardInteractor.removePunishments,
          ),
        ]),
      ],
    );
  }

  @override
  void dispose() {
    _scoreboardInteractor.dispose();
    super.dispose();
  }
}
