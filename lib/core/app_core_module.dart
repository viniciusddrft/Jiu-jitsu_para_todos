import 'package:flutter_modular/flutter_modular.dart';
import 'package:jiu_jitsu_para_todos/src/modules/credits/credits_module.dart';
import 'package:jiu_jitsu_para_todos/src/modules/home/home_module.dart';
import 'package:jiu_jitsu_para_todos/src/modules/settings/settings_module.dart';
import 'package:jiu_jitsu_para_todos/src/modules/wallpapers/wallpaper_module.dart';
import 'package:jiu_jitsu_para_todos/src/shared/l10n/locale_app.dart';
import 'package:jiu_jitsu_para_todos/src/shared/plugins/local_storage/interface/local_storage_interface.dart';
import 'package:jiu_jitsu_para_todos/src/shared/plugins/local_storage/local_storage_shared_preferrence.dart';
import '../src/modules/fightmarker/fightmarker_module.dart';
import '../src/modules/historyofjiujitsu/historyodjiujitsu_module.dart';
import '../src/modules/quiz/quiz_module.dart';
import '../src/modules/rules/rules_module.dart';
import '../src/shared/plugins/admob/admob_interector.dart';

class AppCoreModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<ILocalStorage>(LocalStorageSharedPreferrence.new);
    i.addSingleton(AdmobInterector.new);
    i.addSingleton(LocaleInterector.new);
  }

  @override
  void routes(RouteManager r) {
    r.module('/', module: HomeModule());
    r.module('/historyojiujitsu', module: HistoryOfJiujitsuModule());
    r.module('/rules', module: RulesModule());
    r.module('/credits', module: CreditsModule());
    r.module('/fightmaker', module: FightmakerModule());
    r.module('/settings', module: SettingsModule());
    r.module('/quiz', module: QuizModule());
    r.module('/wallpaper', module: WallpaperModule());
  }
}
