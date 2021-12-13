import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiu_jitsu_para_todos/src/modules/home/view/components/body_home_page_widget.dart';
import 'package:jiu_jitsu_para_todos/src/shared/appbar_gradient/appbar_gradient.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';
import 'package:wakelock/wakelock.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  void initState() {
    Wakelock.disable();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  void _changesettings() => Navigator.pushNamed(context, '/Settings');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const AppBarGradient(),
        title: Text(AppLocalizations.of(context)!.title_appbar_home_page,
            style: const TextStyle(fontFamily: 'YatraOne')),
        actions: [
          IconButton(
              icon: const Icon(Icons.settings), onPressed: _changesettings),
        ],
      ),
      backgroundColor: AppColors.background,
      body: const BodyHomePage(),
    );
  }
}
