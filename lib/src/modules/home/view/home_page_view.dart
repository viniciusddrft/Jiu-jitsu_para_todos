import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiu_jitsu_para_todos/src/modules/home/view/components/body_home_page_widget.dart';
import 'package:jiu_jitsu_para_todos/src/modules/settings/view/settings_view.dart';
import 'package:jiu_jitsu_para_todos/src/shared/animated_page_route_builder/my_transition_elatic_out.dart';
import 'package:jiu_jitsu_para_todos/src/shared/appbar_gradient/appbar_gradient.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';
import 'package:wakelock/wakelock.dart';

class HomePageView extends StatefulWidget {
  const HomePageView();
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
//------------------------------------------------------------------------------
  void _changesettings() => Navigator.of(context)
      .push(MyTransitionElasticOut(
          route: SettingsView(), duration: Duration(milliseconds: 500)))
      .then((_) => setState(() {}));

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
        flexibleSpace: const AppBarGradient(),
        title: Text('title_appbar_home_page'.tr(),
            style: const TextStyle(fontFamily: 'YatraOne')),
        actions: [
          IconButton(
              icon: const Icon(Icons.settings), onPressed: _changesettings),
        ],
      ),
      backgroundColor: AppColors.background,
      body: BodyHomePage(),
    );
  }
}
