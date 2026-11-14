import 'package:firebase_core/firebase_core.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl_standalone.dart';
import 'package:jiu_jitsu_para_todos/core/app_core_module.dart';

import 'package:jiu_jitsu_para_todos/src/shared/l10n/app_localizations.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';
import 'firebase_options.dart';
import 'src/shared/l10n/locale_app.dart';
import 'src/shared/plugins/admob/admob_interactor.dart';
import 'src/shared/plugins/analytics/analytics_interactor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(ModularApp(
    module: appCoreModule,
    navigatorObservers: [AnalyticsInteractor.observer],
    child: const MyApp(),
  ));

  AdmobInteractor.initialize();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final localeApp = inject<LocaleInteractor>();
  final analytics = inject<AnalyticsInteractor>();

  @override
  void initState() {
    super.initState();
    _initLocale();
  }

  Future<void> _initLocale() async {
    await findSystemLocale();
    await localeApp.getLocalePreference();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: localeApp,
      builder: (_, value, __) => MaterialApp.router(
        title: 'Jiu-jitsu para todos',
        localizationsDelegates: const [
          AppLocalizations.delegate,
          ...GlobalMaterialLocalizations.delegates,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        locale: value,
        // Pacotes que ainda usam package:flutter/material.dart (AdMob,
        // circular_countdown_timer) precisam do Theme/Localizations legado.
        // Remover quando esses pacotes migrarem para o material_ui.
        builder: (context, child) =>
            // ignore: deprecated_member_use
            MaterialUiCompatibilityBridge(child: child!),
        theme: ThemeData(
          primaryColor: AppColors.primary,
          brightness: Brightness.dark,
        ),
        routerConfig: ModularApp.routerConfigOf(context),
      ),
    );
  }

  @override
  void dispose() {
    localeApp.dispose();
    super.dispose();
  }
}
