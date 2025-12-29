import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiu_jitsu_para_todos/src/shared/components/button_menu.dart';
import 'package:jiu_jitsu_para_todos/src/shared/l10n/app_localizations.dart';
import '../../../shared/components/app_bar_gradient.dart';
import '../../../shared/themes/app_colors.dart';
import '../../../shared/themes/app_icons_path.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
            onPressed: () => Modular.to.pushNamed('/settings/settings'),
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
              ButtonMenu(
                imageButton: AppIconsPath.iconHistoryOfJiujitsu,
                text: AppLocalizations.of(context)!
                    .button_history_of_jiujitsu_home_page,
                onPressed: () =>
                    Modular.to.pushNamed('/historyojiujitsu/historyojiujitsu'),
              ),
              ButtonMenu(
                imageButton: AppIconsPath.rules,
                text: AppLocalizations.of(context)!.button_rules_home_page,
                onPressed: () => Modular.to.pushNamed('/rules/rules'),
              ),
              ButtonMenu(
                imageButton: AppIconsPath.quiz,
                text: AppLocalizations.of(context)!.button_quiz_home_page,
                onPressed: () => Modular.to.pushNamed('/quiz/menu'),
              ),
              ButtonMenu(
                imageButton: AppIconsPath.fightMarker,
                text:
                    AppLocalizations.of(context)!.button_fight_marker_home_page,
                onPressed: () => Modular.to.pushNamed('/fightmaker/fightmaker'),
              ),
              ButtonMenu(
                imageButton: AppIconsPath.wallpapers,
                text: AppLocalizations.of(context)!.button_wallpapers_home_page,
                onPressed: () => Modular.to.pushNamed('/wallpaper/wallpapers'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
