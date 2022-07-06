import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wakelock/wakelock.dart';

import '../../../shared/appbar_gradient/appbar_gradient.dart';
import '../../../shared/themes/app_colors.dart';

import 'components/components/clock_widget.dart';
import 'components/components/scoreboard_widget.dart';

class FightMakerView extends StatefulWidget {
  const FightMakerView({super.key});

  @override
  State<FightMakerView> createState() => _FightMakerViewState();
}

class _FightMakerViewState extends State<FightMakerView> {
  @override
  void initState() {
    Wakelock.enable();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const AppBarGradient(),
        title: Text(AppLocalizations.of(context)!.title_appbar_fightmarker_page,
            style: const TextStyle(fontFamily: 'YatraOne')),
      ),
      backgroundColor: AppColors.background,
      body: Row(
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
      ),
    );
  }
}
