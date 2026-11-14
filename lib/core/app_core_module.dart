import 'package:flutter_modular/flutter_modular.dart';
import '../src/modules/credits/credits_module.dart';
import '../src/modules/fightmarker/fightmarker_module.dart';
import '../src/modules/historyofjiujitsu/historyodjiujitsu_module.dart';
import '../src/modules/home/home_module.dart';
import '../src/modules/quiz/quiz_module.dart';
import '../src/modules/rules/rules_module.dart';
import '../src/modules/settings/settings_module.dart';
import '../src/modules/wallpapers/wallpaper_module.dart';
import '../src/shared/l10n/locale_app.dart';
import '../src/shared/plugins/admob/admob_interactor.dart';
import '../src/shared/plugins/analytics/analytics_interactor.dart';
import '../src/shared/plugins/in_app_review/in_app_review_interactor.dart';
import '../src/shared/plugins/local_storage/interface/local_storage_interface.dart';
import '../src/shared/plugins/local_storage/local_storage_shared_preferrence.dart';

/// Dependências compartilhadas (sem path → root-owned, nunca descartadas).
final sharedModule = createModule(
  register: (c) => c
    ..addSingleton<ILocalStorage>(LocalStorageSharedPreferrence.new)
    ..addSingleton(AdmobInteractor.new)
    ..addSingleton(InAppReviewInteractor.new)
    ..addSingleton(AnalyticsInteractor.new)
    ..addSingleton(LocaleInteractor.new),
);

final appCoreModule = createModule(
  register: (c) => c
    ..module(sharedModule)
    ..module(homeModule)
    ..module(historyOfJiujitsuModule)
    ..module(rulesModule)
    ..module(creditsModule)
    ..module(fightmakerModule)
    ..module(settingsModule)
    ..module(quizModule)
    ..module(wallpaperModule),
);
