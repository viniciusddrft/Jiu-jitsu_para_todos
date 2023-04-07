import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../shared/appbar_gradient/appbar_gradient.dart';
import '../../../shared/mixins/device_orientation.dart';
import '../../../shared/themes/app_colors.dart';
import '../../../shared/themes/app_icons_path.dart';

import 'components/button_options_home_widget.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});
  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> with DeviceOrientationApp {
  @override
  void initState() {
    configPortrait();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const AppBarGradient(),
        title: Text(AppLocalizations.of(context)!.title_appbar_home_page,
            style: GoogleFonts.yatraOne()),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/Settings'),
          ),
        ],
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        key: const Key('value'),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Column(
            children: [
              ButtonOptionsHome(
                imageButton: AppIconsPath.iconHistoryOfJiujitsu,
                textButton: AppLocalizations.of(context)!
                    .button_history_of_jiujitsu_home_page,
                routeButton: '/HistoryOfJiujitsu', // <- '/historyofjiujitsu',
              ),
              ButtonOptionsHome(
                imageButton: AppIconsPath.rules,
                textButton:
                    AppLocalizations.of(context)!.button_rules_home_page,
                routeButton: '/Rules', // <- '/rules',
              ),
              ButtonOptionsHome(
                  imageButton: AppIconsPath.quiz,
                  textButton:
                      AppLocalizations.of(context)!.button_quiz_home_page,
                  routeButton: '/Quiz' // <- '/quiz',
                  ),
              ButtonOptionsHome(
                imageButton: AppIconsPath.fightMarker,
                textButton:
                    AppLocalizations.of(context)!.button_fight_marker_home_page,
                routeButton: '/Fightmarker', // <- '/fightmarker',
                isFightMakerView: true,
              ),
              ButtonOptionsHome(
                imageButton: AppIconsPath.wallpapers,
                textButton:
                    AppLocalizations.of(context)!.button_wallpapers_home_page,
                routeButton: '/Wallpapers', // <- '/wallpapers',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
