import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jiu_jitsu_para_todos/app_module.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';
import 'firebase_options.dart';
import 'src/shared/l10n/locale_app.dart';
import 'src/shared/plugins/admob/admob_interector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AdmobInterector.initialize();

  runApp(ModularApp(
    module: AppModule(),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final localeApp = Modular.get<LocaleInterector>();

  @override
  void didChangeDependencies() {
    localeApp.getLocalePreference();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: localeApp,
      builder: (context, value, child) => MaterialApp.router(
        title: 'Jiu-jitsu para todos',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: value,
        theme: ThemeData(
          primaryColor: AppColors.primary,
          brightness: Brightness.dark,
          useMaterial3: true,
        ),
        routerConfig: Modular.routerConfig,
      ),
    );
  }

  @override
  void dispose() {
    localeApp.dispose();
    super.dispose();
  }
}
