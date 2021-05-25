import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/views/fightmarker/fight_marker_view.dart';
import 'package:jiu_jitsu_para_todos/src/views/historyofjiujitsu/history_of_jiu_jitsu_view.dart';
import 'package:jiu_jitsu_para_todos/src/views/home/components/button_options_home_widget.dart';
import 'package:jiu_jitsu_para_todos/src/views/quiz/quiz_view.dart';
import 'package:jiu_jitsu_para_todos/src/views/rules/rules_view.dart';
import 'package:jiu_jitsu_para_todos/src/views/wallpapers/wallpapers_view.dart';
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
              imagebotton: 'assets/images/iconsbutton/historyofjiujitsu.png',
              textbotton: 'button_history_of_jiujitsu_home_page'.tr(),
              routebotton: HistoryOfJiuJitsuView(), // <- '/historyofjiujitsu',
            ),
            BottonOptionsHome(
              imagebotton: 'assets/images/iconsbutton/rules.png',
              textbotton: 'button_rules_home_page'.tr(),
              routebotton: RulesView(), // <- '/rules',
            ),
            BottonOptionsHome(
                imagebotton: 'assets/images/iconsbutton/quiz.png',
                textbotton: 'button_quiz_home_page'.tr(),
                routebotton: QuizView() // <- '/quiz',
                ),
            BottonOptionsHome(
              imagebotton: 'assets/images/iconsbutton/fightmarker.png',
              textbotton: 'button_fight_marker_home_page'.tr(),
              routebotton: FightMakerView(), // <- '/fightmarker',
              needtorebuildthehouse: true,
              needanimation: false,
            ),
            BottonOptionsHome(
              imagebotton: 'assets/images/iconsbutton/wallpapers.png',
              textbotton: 'button_wallpapers_home_page'.tr(),
              routebotton: WallpapersView(), // <- '/wallpapers',
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
