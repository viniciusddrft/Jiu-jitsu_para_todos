import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/modules/home/view/components/components/button_options_home_widget.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_icons_path.dart';
import 'package:easy_localization/easy_localization.dart';

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
              imageButtonOptionsHome: AppIconsPath.iconHistoryOfJiujitsu,
              textButtonOptionsHome:
                  'button_history_of_jiujitsu_home_page'.tr(),
              routeButton: '/HistoryOfJiujitsu', // <- '/historyofjiujitsu',
            ),
            ButtonOptionsHome(
              imageButtonOptionsHome: AppIconsPath.rules,
              textButtonOptionsHome: 'button_rules_home_page'.tr(),
              routeButton: '/Rules', // <- '/rules',
            ),
            ButtonOptionsHome(
                imageButtonOptionsHome: AppIconsPath.quiz,
                textButtonOptionsHome: 'button_quiz_home_page'.tr(),
                routeButton: '/Quiz' // <- '/quiz',
                ),
            ButtonOptionsHome(
              imageButtonOptionsHome: AppIconsPath.fightMarker,
              textButtonOptionsHome: 'button_fight_marker_home_page'.tr(),
              routeButton: '/Fightmarker', // <- '/fightmarker',
              isFightMakerView: true,
            ),
            ButtonOptionsHome(
              imageButtonOptionsHome: AppIconsPath.wallpapers,
              textButtonOptionsHome: 'button_wallpapers_home_page'.tr(),
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
