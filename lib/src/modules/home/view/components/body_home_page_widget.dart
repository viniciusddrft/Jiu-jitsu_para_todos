import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/modules/historyofjiujitsu/view/historyofjiujitsumenu/history_of_jiu_jitsu_view.dart';
import 'package:jiu_jitsu_para_todos/src/modules/home/view/components/components/button_options_home_widget.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/view/quizmenu/quiz_view.dart';
import 'package:jiu_jitsu_para_todos/src/modules/fightmarker/view/fight_marker_view.dart';
import 'package:jiu_jitsu_para_todos/src/modules/rules/view/rulesmenu/rules_view.dart';
import 'package:jiu_jitsu_para_todos/src/modules/wallpapers/view/wallpapersmenu/wallpapers_view.dart';
import 'package:easy_localization/easy_localization.dart';

class BodyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            BottonOptionsHome(
              imageButton: 'assets/images/iconsbutton/historyofjiujitsu.png',
              textButton: 'button_history_of_jiujitsu_home_page'.tr(),
              routeButton: HistoryOfJiuJitsuView(), // <- '/historyofjiujitsu',
            ),
            BottonOptionsHome(
              imageButton: 'assets/images/iconsbutton/rules.png',
              textButton: 'button_rules_home_page'.tr(),
              routeButton: RulesView(), // <- '/rules',
            ),
            BottonOptionsHome(
                imageButton: 'assets/images/iconsbutton/quiz.png',
                textButton: 'button_quiz_home_page'.tr(),
                routeButton: QuizView() // <- '/quiz',
                ),
            BottonOptionsHome(
              imageButton: 'assets/images/iconsbutton/fightmarker.png',
              textButton: 'button_fight_marker_home_page'.tr(),
              routeButton: FightMakerView(), // <- '/fightmarker',
              needToRebuildTheHome: true,
              needAnimation: false,
            ),
            BottonOptionsHome(
              imageButton: 'assets/images/iconsbutton/wallpapers.png',
              textButton: 'button_wallpapers_home_page'.tr(),
              routeButton: WallpapersView(), // <- '/wallpapers',
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
