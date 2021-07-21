import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/modules/home/view/home_page_view.dart';
import 'package:jiu_jitsu_para_todos/src/modules/splash/view/splash_page_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(411.4, 820.6),
      builder: () => MaterialApp(
        title: 'Jiu-jitsu para todos',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          fontFamily: 'Ubuntu',
          primaryColor: AppColors.primary,
          accentColor: Colors.indigo, // Color(0xff65d1ba),
          brightness: Brightness.dark,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/splash',
        routes: {
          '/splash': (BuildContext context) => SplashPageView(),
          '/home': (BuildContext context) => HomePageView(),
          /*
          '/settings': (BuildContext context) => SettingsView(),
          '/fightmarker': (BuildContext context) => FightMakerView(),
          '/historyofjiujitsu': (BuildContext context) =>
              HistoryOfJiuJitsuView(),
          '/rules': (BuildContext context) => RulesView(),
          '/quiz': (BuildContext context) => QuizView(),
          '/questionsquiz': (BuildContext context) => QuestionsQuiz(),
          '/failedinquiz': (BuildContext context) => FailedInQuiz(),
          '/winnerinquiz': (BuildContext context) => WinnerInQuiz(),
          '/basicrules': (BuildContext context) => Basicrules(),
          '/cbjjrules': (BuildContext context) => Cbjjrules(),
          '/wallpapers': (BuildContext context) => WallpapersView(),
          '/credits': (BuildContext context) => CreditsView(),
          '/detailsimage': (BuildContext context) => DetailsImage(),*/
        },
      ),
    );
  }
}
