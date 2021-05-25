import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/views/home/home_page_view.dart';
import 'package:jiu_jitsu_para_todos/src/views/splash/splash_page_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(411.4, 820.6),
      builder: () => MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          fontFamily: 'Ubuntu',
          primaryColor: Color(0xff1b2c57),
          accentColor: Colors.indigo, // Color(0xff65d1ba),
          brightness: Brightness.dark,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/splash',
        routes: {
          '/splash': (BuildContext context) => SplashPageView(),
          '/home': (BuildContext context) => HomePageView(),
          /*
          settings': (BuildContext context) => SettingsView(),
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
