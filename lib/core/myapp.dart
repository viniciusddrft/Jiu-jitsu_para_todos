import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl_standalone.dart';
import 'package:jiu_jitsu_para_todos/core/locale/locale_app.dart';
import 'package:jiu_jitsu_para_todos/core/routes/routes_app.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    LocaleAppNotifier.of(context).getLocalePreference();
    findSystemLocale();
    super.initState();
  }

  @override
  void dispose() {
    LocaleAppNotifier.of(context).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: LocaleAppNotifier.of(context),
      builder: (BuildContext context, Locale value, Widget? child) =>
          MaterialApp(
        title: 'Jiu-jitsu para todos',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: value,
        theme: ThemeData(
          fontFamily: 'Ubuntu',
          primaryColor: AppColors.primary,
          brightness: Brightness.dark,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/Home',
        onGenerateRoute: Routes.routes,
      ),
    );
  }
}
