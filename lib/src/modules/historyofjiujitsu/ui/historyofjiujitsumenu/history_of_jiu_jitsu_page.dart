import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiu_jitsu_para_todos/src/shared/components/button_menu.dart';
import '../../../../shared/components/app_bar_gradient.dart';
import '../../../../shared/themes/app_colors.dart';
import '../../../../shared/themes/app_icons_path.dart';

class HistoryOfJiuJitsuPage extends StatelessWidget {
  const HistoryOfJiuJitsuPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const AppBarGradient(),
        title: Text(
            AppLocalizations.of(context)!.title_appbar_history_of_jiujitsu_page,
            style: GoogleFonts.yatraOne()),
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
              child: Text(
                AppLocalizations.of(context)!.history_of_jiujitsu_page_summary,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            ButtonMenu(
              imageButton: AppIconsPath.japao,
              text:
                  '    ${AppLocalizations.of(context)!.button_jiujitsu_in_japao}',
              onPressed: () =>
                  Modular.to.pushNamed('/historyojiujitsu/originofjiujitsu'),
            ),
            ButtonMenu(
              imageButton: AppIconsPath.india,
              text:
                  '    ${AppLocalizations.of(context)!.button_jiujitsu_in_india}',
              onPressed: () =>
                  Modular.to.pushNamed('/historyojiujitsu/originofjiujitsu'),
            ),
            ButtonMenu(
              imageButton: AppIconsPath.brasil,
              text:
                  '    ${AppLocalizations.of(context)!.button_jiujitsu_in_brazil}',
              onPressed: () =>
                  Modular.to.pushNamed('/historyojiujitsu/jiujitsuinbrazil'),
            ),
          ],
        ),
      ),
    );
  }
}
