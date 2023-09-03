import 'package:flutter_modular/flutter_modular.dart';
import 'package:jiu_jitsu_para_todos/src/features/credits/credits_module.dart';
import 'package:jiu_jitsu_para_todos/src/features/home/home_module.dart';
import 'package:jiu_jitsu_para_todos/src/features/settings/settings_module.dart';
import 'package:jiu_jitsu_para_todos/src/features/wallpapers/wallpaper_module.dart';
import 'package:jiu_jitsu_para_todos/src/shared/l10n/locale_app.dart';
import 'package:jiu_jitsu_para_todos/src/shared/plugins/local_storage/interface/local_storage_interface.dart';
import 'package:jiu_jitsu_para_todos/src/shared/plugins/local_storage/local_storage_shared_preferrence.dart';
import '../src/features/fightmarker/fightmarker_module.dart';
import '../src/features/historyofjiujitsu/historyodjiujitsu_module.dart';
import '../src/features/quiz/quiz_module.dart';
import '../src/features/rules/rules_module.dart';
import '../src/shared/plugins/admob/admob_interector.dart';

class AppCoreModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<ILocalStorage>(LocalStorageSharedPreferrence.new);
    i.addSingleton(AdmobInterector.new);
    i.addSingleton(LocaleInterector.new);
    super.binds(i);
  }

  @override
  void routes(r) {
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
