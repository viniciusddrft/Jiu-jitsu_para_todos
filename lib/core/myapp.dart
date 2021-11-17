import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/core/routes/routes_app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';

class MyApp extends StatelessWidget {
  const MyApp();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 820.6),
      builder: () => MaterialApp(
        title: 'Jiu-jitsu para todos',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          fontFamily: 'Ubuntu',
          primaryColor: AppColors.primary,
          brightness: Brightness.dark,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/Home',
        onGenerateRoute: (RouteSettings settings) => Routes.routes(settings),
      ),
    );
  }
}
