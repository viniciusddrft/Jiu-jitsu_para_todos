import 'package:flutter/material.dart';
import 'package:intl/intl_standalone.dart';
import 'package:jiu_jitsu_para_todos/core/locale/locale_app.dart';
import 'package:jiu_jitsu_para_todos/core/routes/routes_app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    LocaleApp.getLocalePreference();
    findSystemLocale();
    super.initState();
  }

  @override
  void dispose() {
    LocaleApp.localeApp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 820.6),
      builder: () => ValueListenableBuilder(
        valueListenable: LocaleApp.localeApp,
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
          onGenerateRoute: (RouteSettings settings) => Routes.routes(settings),
        ),
      ),
    );
  }
}
