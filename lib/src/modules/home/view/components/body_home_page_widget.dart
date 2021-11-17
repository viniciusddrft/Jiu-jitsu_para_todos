import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/modules/home/view/components/components/button_options_home_widget.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_icons_path.dart';
import 'package:easy_localization/easy_localization.dart';

class BodyHomePage extends StatelessWidget {
  BodyHomePage();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ButtonOptionsHome(
              imageButton: AppIconsPath.iconHistoryOfJiujitsu,
              textButton: 'button_history_of_jiujitsu_home_page'.tr(),
              routeButton: '/HistoryOfJiujitsu', // <- '/historyofjiujitsu',
            ),
            ButtonOptionsHome(
              imageButton: AppIconsPath.rules,
              textButton: 'button_rules_home_page'.tr(),
              routeButton: '/Rules', // <- '/rules',
            ),
            ButtonOptionsHome(
                imageButton: AppIconsPath.quiz,
                textButton: 'button_quiz_home_page'.tr(),
                routeButton: '/Quiz' // <- '/quiz',
                ),
            ButtonOptionsHome(
              imageButton: AppIconsPath.fightMarker,
              textButton: 'button_fight_marker_home_page'.tr(),
              routeButton: '/Fightmarker', // <- '/fightmarker',
              isFightMakerView: true,
            ),
            ButtonOptionsHome(
              imageButton: AppIconsPath.wallpapers,
              textButton: 'button_wallpapers_home_page'.tr(),
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
