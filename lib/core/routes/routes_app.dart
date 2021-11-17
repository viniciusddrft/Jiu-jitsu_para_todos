import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/core/routes/animations/transition_elatic_out.dart';
import 'package:jiu_jitsu_para_todos/core/routes/animations/transition_left_to_right.dart';
import 'package:jiu_jitsu_para_todos/src/modules/credits/view/credits_view.dart';
import 'package:jiu_jitsu_para_todos/src/modules/fightmarker/view/fight_marker_view.dart';
import 'package:jiu_jitsu_para_todos/src/modules/historyofjiujitsu/view/historyofjiujitsumenu/history_of_jiu_jitsu_view.dart';
import 'package:jiu_jitsu_para_todos/src/modules/historyofjiujitsu/view/jiujitsuinbrazil/jiu_jitsu_in_brazil_view.dart';
import 'package:jiu_jitsu_para_todos/src/modules/historyofjiujitsu/view/originofjiujitsu/origin_of_jiu_jitsu_view.dart';
import 'package:jiu_jitsu_para_todos/src/modules/home/view/home_page_view.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/view/quizmenu/quiz_view.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/view/quizquestions/quiz_questions_view.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/view/quizresult/result_quiz.dart';
import 'package:jiu_jitsu_para_todos/src/modules/rules/view/basicrules/basic_rules_view.dart';
import 'package:jiu_jitsu_para_todos/src/modules/rules/view/cbjjrules/cbjj_rules_view.dart';
import 'package:jiu_jitsu_para_todos/src/modules/rules/view/rulesmenu/rules_view.dart';
import 'package:jiu_jitsu_para_todos/src/modules/settings/view/settings_view.dart';
import 'package:jiu_jitsu_para_todos/src/modules/wallpapers/view/detailsimage/details_image_view.dart';
import 'package:jiu_jitsu_para_todos/src/modules/wallpapers/view/wallpapersmenu/wallpapers_view.dart';

class Routes {
  static Route<dynamic>? routes(RouteSettings settings) {
    if (settings.name == "/Home") {
      return MaterialPageRoute(
        builder: (BuildContext context) => HomePageView(),
      );
    } else if (settings.name == "/Settings") {
      return TransitionElasticOut(
        duration: Duration(milliseconds: 500),
        route: SettingsView(),
      );
    } else if (settings.name == "/Credits") {
      return TransitionLeftToRight(
        duration: Duration(milliseconds: 300),
        route: CreditsView(),
      );
    } else if (settings.name == "/HistoryOfJiujitsu") {
      return TransitionElasticOut(
        duration: Duration(milliseconds: 500),
        route: HistoryOfJiuJitsuView(),
      );
    } else if (settings.name == "/Rules") {
      return TransitionElasticOut(
        duration: Duration(milliseconds: 500),
        route: RulesView(),
      );
    } else if (settings.name == "/Quiz") {
      return TransitionElasticOut(
        duration: Duration(milliseconds: 500),
        route: QuizView(),
      );
    } else if (settings.name == "/Fightmarker") {
      return TransitionElasticOut(
        duration: Duration(milliseconds: 500),
        route: FightMakerView(),
      );
    } else if (settings.name == "/Wallpapers") {
      return TransitionElasticOut(
        duration: Duration(milliseconds: 500),
        route: WallpapersView(),
      );
    } else if (settings.name == "/JiujitsuInBrazil") {
      return TransitionLeftToRight(
        duration: Duration(milliseconds: 300),
        route: JiujitsuinBrazil(),
      );
    } else if (settings.name == "/OriginOfJiujitsu") {
      return TransitionLeftToRight(
        duration: Duration(milliseconds: 300),
        route: OriginOfJiujitsu(),
      );
    } else if (settings.name == "/BasicRules") {
      return TransitionLeftToRight(
        duration: Duration(milliseconds: 300),
        route: Basicrules(),
      );
    } else if (settings.name == "/CbjjRules") {
      return TransitionLeftToRight(
        duration: Duration(milliseconds: 300),
        route: Cbjjrules(),
      );
    } else if (settings.name == "/DetailsImage" && settings.arguments != null) {
      return MaterialPageRoute(
        builder: (BuildContext context) => DetailsImage(
          imagePath: (settings.arguments as Map<String, dynamic>)['imagePath'],
          index: (settings.arguments as Map<String, dynamic>)['index'],
        ),
      );
    } else if (settings.name == "/QuizQuestions" &&
        settings.arguments != null) {
      return TransitionLeftToRight(
        duration: Duration(milliseconds: 300),
        route: QuizQuestions(
          difficulty:
              (settings.arguments as Map<String, String>)['difficulty']!,
          difficultyName:
              (settings.arguments as Map<String, String>)['difficultyName']!,
        ),
      );
    } else if (settings.name == "/ResultQuiz" && settings.arguments != null) {
      return TransitionElasticOut(
        duration: Duration(milliseconds: 500),
        route: ResultQuiz(
          difficultyName:
              (settings.arguments as Map<String, dynamic>)['difficultyName'],
          score: (settings.arguments as Map<String, dynamic>)['score'],
          totalQuestions:
              (settings.arguments as Map<String, dynamic>)['totalQuestions'],
        ),
      );
    }
  }
}
