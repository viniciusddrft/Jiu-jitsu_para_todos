import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../shared/themes/app_icons_path.dart';
import 'components/button_options_home_widget.dart';

class BodyHomePage extends StatefulWidget {
  const BodyHomePage({super.key});

  @override
  State<BodyHomePage> createState() => _BodyHomePageState();
}

class _BodyHomePageState extends State<BodyHomePage> {
  //this setState fixes the size of texts on this screen due to rotation
  @override
  void didChangeDependencies() {
    Future.delayed(Duration.zero, () => setState(() {}));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      width: size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ButtonOptionsHome(
              imageButton: AppIconsPath.iconHistoryOfJiujitsu,
              textButton: AppLocalizations.of(context)!
                  .button_history_of_jiujitsu_home_page,
              routeButton: '/HistoryOfJiujitsu', // <- '/historyofjiujitsu',
            ),
            ButtonOptionsHome(
              imageButton: AppIconsPath.rules,
              textButton: AppLocalizations.of(context)!.button_rules_home_page,
              routeButton: '/Rules', // <- '/rules',
            ),
            ButtonOptionsHome(
                imageButton: AppIconsPath.quiz,
                textButton: AppLocalizations.of(context)!.button_quiz_home_page,
                routeButton: '/Quiz' // <- '/quiz',
                ),
            ButtonOptionsHome(
              imageButton: AppIconsPath.fightMarker,
              textButton:
                  AppLocalizations.of(context)!.button_fight_marker_home_page,
              routeButton: '/Fightmarker', // <- '/fightmarker',
              isFightMakerView: true,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.1),
              child: ButtonOptionsHome(
                imageButton: AppIconsPath.wallpapers,
                textButton:
                    AppLocalizations.of(context)!.button_wallpapers_home_page,
                routeButton: '/Wallpapers', // <- '/wallpapers',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
