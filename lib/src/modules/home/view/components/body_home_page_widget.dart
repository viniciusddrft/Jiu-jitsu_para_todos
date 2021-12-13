import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/modules/home/view/components/components/button_options_home_widget.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_icons_path.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BodyHomePage extends StatefulWidget {
  const BodyHomePage({Key? key}) : super(key: key);

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
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.height,
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
            ButtonOptionsHome(
              imageButton: AppIconsPath.wallpapers,
              textButton:
                  AppLocalizations.of(context)!.button_wallpapers_home_page,
              routeButton: '/Wallpapers', // <- '/wallpapers',
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            )
          ],
        ),
      ),
    );
  }
}
