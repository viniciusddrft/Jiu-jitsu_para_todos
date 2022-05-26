import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wakelock/wakelock.dart';

import '../../../shared/appbar_gradient/appbar_gradient.dart';
import '../../../shared/themes/app_colors.dart';
import 'components/body_home_page_widget.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});
  @override
  State<HomePageView> createState() => _HomePageViewState();
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
