import 'package:flutter_modular/flutter_modular.dart';
import 'package:jiu_jitsu_para_todos/src/features/fightmarker/interector/clock_interector.dart';
import 'package:jiu_jitsu_para_todos/src/features/historyofjiujitsu/ui/jiujitsuinbrazil/jiu_jitsu_in_brazil_view.dart';
import 'package:jiu_jitsu_para_todos/src/features/home/ui/home_page.dart';
import 'package:jiu_jitsu_para_todos/src/features/quiz/interector/interfaces/ifirebase_quiz.dart';
import 'package:jiu_jitsu_para_todos/src/features/rules/ui/cbjjrules/cbjj_rules_view.dart';
import 'package:jiu_jitsu_para_todos/src/features/settings/ui/settings_page.dart';
import 'package:jiu_jitsu_para_todos/src/features/wallpapers/interector/interfaces/ifirebase_wallpapers.dart';
import 'package:jiu_jitsu_para_todos/src/features/wallpapers/ui/details_image_page.dart';
import 'package:jiu_jitsu_para_todos/src/shared/l10n/locale_app.dart';
import 'package:jiu_jitsu_para_todos/src/shared/plugins/local_storage/interface/local_storage_interface.dart';
import 'package:jiu_jitsu_para_todos/src/shared/plugins/local_storage/local_storage_shared_preferrence.dart';
import 'package:jiu_jitsu_para_todos/src/shared/plugins/sound/sound_implements_just_audio.dart';
import 'src/features/credits/ui/credits.dart';
import 'src/features/fightmarker/interector/scorreboard_interector.dart';
import 'src/features/fightmarker/ui/fightmarker_page.dart';
import 'src/features/historyofjiujitsu/ui/historyofjiujitsumenu/history_of_jiu_jitsu_page.dart';
import 'src/features/historyofjiujitsu/ui/originofjiujitsu/origin_of_jiu_jitsu_view.dart';
import 'src/features/quiz/data/firebase_quiz_impl.dart';
import 'src/features/quiz/interector/quiz_interector.dart';
import 'src/features/quiz/ui/quiz_menu/quiz_menu_page.dart';
import 'src/features/quiz/ui/quiz_questions/quiz_questions_page.dart';
import 'src/features/quiz/ui/quiz_result/quiz_result_page.dart';
import 'src/features/rules/ui/basicrules/basic_rules_view.dart';
import 'src/features/rules/ui/rulesmenu/rules_view.dart';
import 'src/features/settings/interector/settings_interector.dart';
import 'src/features/wallpapers/data/firebase_wallpapers_impl_.dart';
import 'src/features/wallpapers/interector/wallpaper_interector.dart';
import 'src/features/wallpapers/ui/wallpapers_page.dart';
import 'src/shared/plugins/admob/admob_interector.dart';
import 'src/shared/plugins/sound/interface/sound_interface.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.add(SettingsInterector.new);
    i.add<SoundInterface>(JustAudio.new);
    i.add(ScoreboardInterector.new);
    i.add(ClockInterector.new);
    i.add(QuizInteractor.new);
    i.add(WallpaperInteractor.new);
    i.add<IFirebaseQuiz>(FirebaseQuizImpl.new);
    i.add<IFirebaseWallpapers>(FirebaseWallpapersImpl.new);
    i.addSingleton(AdmobInterector.new);
    i.addSingleton(LocaleInterector.new);
    i.addSingleton<ILocalStorage>(LocalStorageSharedPreferrence.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const HomePage());
    r.child('/settings',
        child: (context) => const SettingsPage(),
        transition: TransitionType.rightToLeft);
    r.child('/credits',
        child: (context) => const CreditsPage(),
        transition: TransitionType.downToUp);
    r.child('/fightmaker',
        child: (context) => const FightMakerPage(),
        transition: TransitionType.downToUp);
    r.child('/historyojiujitsu',
        child: (context) => const HistoryOfJiuJitsuPage(),
        transition: TransitionType.rightToLeft);
    r.child('/jiujitsuinbrazil',
        child: (context) => const JiujitsuinBrazilPage(),
        transition: TransitionType.rightToLeft);
    r.child('/originofjiujitsu',
        child: (context) => const OriginOfJiujitsuPage(),
        transition: TransitionType.rightToLeft);
    r.child('/rules',
        child: (context) => const RulesPage(),
        transition: TransitionType.rightToLeft);
    r.child('/cbjjrules',
        child: (context) => const CbjjrulesPage(),
        transition: TransitionType.rightToLeft);
    r.child('/basicrules',
        child: (context) => const BasicRulesPage(),
        transition: TransitionType.rightToLeft);
    r.child('/quizmenu',
        child: (context) => const QuizMenuPage(),
        transition: TransitionType.rightToLeft);
    r.child('/quizquestions',
        child: (context) =>
            QuizQuestionsPage(difficulty: r.args.data as Difficult),
        transition: TransitionType.rightToLeft);
    r.child('/quizresult',
        child: (context) => QuizResultPage(
              difficult: r.args.data['difficult'],
              score: r.args.data['score'],
              totalQuestions: r.args.data['totalQuestions'],
            ),
        transition: TransitionType.downToUp);
    r.child('/wallpapers',
        child: (context) => const WallpapersPage(),
        transition: TransitionType.rightToLeft);
    r.child(
      '/detailsimage',
      child: (context) => DetailsImagePage(
        index: r.args.data['index'],
        imageUrl: r.args.data['imageUrl'],
      ),
    );
  }
}
