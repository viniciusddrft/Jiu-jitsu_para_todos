import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiu_jitsu_para_todos/src/views/home/components/body_home_page_widget.dart';
import 'package:jiu_jitsu_para_todos/src/views/shared/appbar_gradient/appbar_gradient.dart';
import 'package:jiu_jitsu_para_todos/src/views/settings/settings_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wakelock/wakelock.dart';

class HomePageView extends StatefulWidget {
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
//------------------------------------------------------------------------------
  void changesettings() async {
    await Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return SettingsView();
        },
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          animation =
              CurvedAnimation(parent: animation, curve: Curves.elasticOut);
          return ScaleTransition(
              alignment: Alignment.center, scale: animation, child: child);
        },
      ),
    );
    setState(() {});
  }

//------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    Wakelock.disable();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: AppBarGradient(),
        title: Text('title_appbar_home_page'.tr(),
            style: TextStyle(fontFamily: 'YatraOne')),
        actions: [
          IconButton(icon: Icon(Icons.settings), onPressed: changesettings),
        ],
      ),
      backgroundColor: Color(0xff202848),
      body: BodyHomePage(),
    );
  }
}
