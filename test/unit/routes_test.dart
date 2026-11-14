import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:jiu_jitsu_para_todos/core/app_core_module.dart';
import 'package:jiu_jitsu_para_todos/src/modules/home/ui/home_page.dart';
import 'package:jiu_jitsu_para_todos/src/modules/fightmarker/ui/fightmarker_page.dart';
import 'package:jiu_jitsu_para_todos/src/modules/settings/ui/settings_page.dart';
import 'package:jiu_jitsu_para_todos/src/modules/rules/ui/rulesmenu/rules_view.dart';
import 'package:jiu_jitsu_para_todos/src/modules/rules/ui/basicrules/basic_rules_view.dart';
import 'package:jiu_jitsu_para_todos/src/modules/rules/ui/cbjjrules/cbjj_rules_view.dart';
import 'package:jiu_jitsu_para_todos/src/modules/historyofjiujitsu/ui/historyofjiujitsumenu/history_of_jiu_jitsu_page.dart';
import 'package:jiu_jitsu_para_todos/src/modules/historyofjiujitsu/ui/jiujitsuinbrazil/jiu_jitsu_in_brazil_view.dart';
import 'package:jiu_jitsu_para_todos/src/modules/historyofjiujitsu/ui/jiujitsuinindia/jiujitsu_in_india_view.dart';
import 'package:jiu_jitsu_para_todos/src/modules/historyofjiujitsu/ui/jiujitsuinjapan/jiujitsu_in_japan_view.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/ui/quiz_menu/quiz_menu_page.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/ui/quiz_questions/quiz_questions_page.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/ui/quiz_result/quiz_result_page.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/interactor/interfaces/ifirebase_quiz.dart';
import 'package:jiu_jitsu_para_todos/src/modules/wallpapers/ui/wallpapers_page.dart';
import 'package:jiu_jitsu_para_todos/src/modules/wallpapers/ui/details_image_page.dart';
import 'package:jiu_jitsu_para_todos/src/modules/wallpapers/interactor/wallpaper_entity.dart';

class _Context extends Mock implements BuildContext {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    setupFirebaseCoreMocks();
    await Firebase.initializeApp();
  });
  test(
      'módulo principal resolve os destinos usados pelos menus e preserva argumentos',
      () {
    final boot = bootstrapModule(appCoreModule);
    addTearDown(boot.injector.dispose);
    final context = _Context();
    Widget resolve(String path, [Object? arguments]) {
      final uri = Uri.parse(path);
      final match = boot.routes.match(uri);
      expect(match, isNotNull, reason: 'Rota $path deve existir');
      return match!.last.route
          .builder(context, RouteState(uri: uri, arguments: arguments));
    }

    final destinations = {
      '/': HomePage,
      '/settings/settings': SettingsPage,
      '/fightmaker/fightmaker': FightMakerPage,
      '/rules/rules': RulesPage,
      '/rules/basicrules': BasicRulesPage,
      '/rules/cbjjrules': CbjjrulesPage,
      '/historyojiujitsu/historyojiujitsu': HistoryOfJiuJitsuPage,
      '/historyojiujitsu/jiujitsuinbrazil': JiujitsuinBrazilPage,
      '/historyojiujitsu/jiujitsuinindia': JiujitsuInIndiaView,
      '/historyojiujitsu/jiujitsuinjapan': JiujitsuInJapanView,
      '/quiz/menu': QuizMenuPage,
      '/wallpaper/wallpapers': WallpapersPage,
    };
    for (final entry in destinations.entries) {
      expect(resolve(entry.key).runtimeType, entry.value);
    }
    final questions =
        resolve('/quiz/questions', Difficult.hard) as QuizQuestionsPage;
    expect(questions.difficulty, Difficult.hard);
    final result = resolve('/quiz/result', {
      'difficult': Difficult.medium,
      'score': 8,
      'totalQuestions': 10
    }) as QuizResultPage;
    expect(result.difficult, Difficult.medium);
    expect(result.score, 8);
    expect(result.totalQuestions, 10);
    const images = [
      WallpaperEntity(url: 'image0'),
      WallpaperEntity(url: 'image1')
    ];
    final details =
        resolve('/wallpaper/detailsimage', {'wallpapers': images, 'index': 1})
            as DetailsImagePage;
    expect(details.wallpapers, images);
    expect(details.initialIndex, 1);
  });
}
