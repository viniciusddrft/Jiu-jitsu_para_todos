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
    switch (settings.name) {
      case '/Home':
        return MaterialPageRoute(
          builder: (BuildContext context) => const HomePageView(),
        );
      case '/Settings':
        return TransitionElasticOut(
          duration: const Duration(milliseconds: 500),
          route: const SettingsView(),
        );
      case '/Credits':
        return TransitionLeftToRight(
          duration: const Duration(milliseconds: 300),
          route: const CreditsView(),
        );
      case '/HistoryOfJiujitsu':
        return TransitionElasticOut(
          duration: const Duration(milliseconds: 500),
          route: const HistoryOfJiuJitsuView(),
        );
      case '/Rules':
        return TransitionElasticOut(
          duration: const Duration(milliseconds: 500),
          route: const RulesView(),
        );
      case '/Quiz':
        return TransitionElasticOut(
          duration: const Duration(milliseconds: 500),
          route: const QuizView(),
        );
      case '/Fightmarker':
        return TransitionElasticOut(
          duration: const Duration(milliseconds: 500),
          route: const FightMakerView(),
        );
      case '/Wallpapers':
        return TransitionElasticOut(
          duration: const Duration(milliseconds: 500),
          route: const WallpapersView(),
        );
      case '/JiujitsuInBrazil':
        return TransitionLeftToRight(
          duration: const Duration(milliseconds: 300),
          route: const JiujitsuinBrazil(),
        );
      case '/OriginOfJiujitsu':
        return TransitionLeftToRight(
          duration: const Duration(milliseconds: 300),
          route: const OriginOfJiujitsu(),
        );
      case '/BasicRules':
        return TransitionLeftToRight(
          duration: const Duration(milliseconds: 300),
          route: const Basicrules(),
        );
      case '/CbjjRules':
        return TransitionLeftToRight(
          duration: const Duration(milliseconds: 300),
          route: const Cbjjrules(),
        );
      case '/DetailsImage':
        return MaterialPageRoute(
          builder: (BuildContext context) => DetailsImage(
            imageUrl: (settings.arguments as Map<String, dynamic>)['imageUrl'],
            index: (settings.arguments as Map<String, dynamic>)['index'],
          ),
        );
      case '/QuizQuestions':
        return TransitionLeftToRight(
          duration: const Duration(milliseconds: 300),
          route: QuizQuestions(
            difficulty:
                (settings.arguments as Map<String, String>)['difficulty']!,
            difficultyName:
                (settings.arguments as Map<String, String>)['difficultyName']!,
          ),
        );
      case '/ResultQuiz':
        return TransitionElasticOut(
          duration: const Duration(milliseconds: 500),
          route: ResultQuiz(
            difficultyName:
                (settings.arguments as Map<String, dynamic>)['difficultyName'],
            score: (settings.arguments as Map<String, dynamic>)['score'],
            totalQuestions:
                (settings.arguments as Map<String, dynamic>)['totalQuestions'],
          ),
        );
    }
    return null;
  }
}
