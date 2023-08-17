import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiu_jitsu_para_todos/src/shared/components/button_menu.dart';
import '../../../../shared/components/app_bar_gradient.dart';
import '../../../../shared/themes/app_colors.dart';
import '../../../../shared/themes/app_icons_path.dart';

class RulesPage extends StatelessWidget {
  const RulesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const AppBarGradient(),
        title: Text(AppLocalizations.of(context)!.title_appbar_rule_page,
            style: GoogleFonts.yatraOne()),
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ButtonMenu(
              imageButton: AppIconsPath.regrasBasicas,
              text: AppLocalizations.of(context)!.button_basic_rules,
              onPressed: () => Modular.to.pushNamed('/basicrules'),
            ),
            ButtonMenu(
                imageButton: AppIconsPath.cbjjRules,
                text: AppLocalizations.of(context)!.button_cbjj_Rules,
                onPressed: () => Modular.to.pushNamed('/cbjjrules')),
          ],
        ),
      ),
    );
  }
}
