import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/appbar_gradient/appbar_gradient.dart';
import '../../../../shared/themes/app_colors.dart';
import '../../../../shared/themes/app_icons_path.dart';

import 'components/button_options_rules_widget.dart';

class RulesView extends StatelessWidget {
  const RulesView({super.key});
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
            ButtonOptionsRules(
                imageButton: AppIconsPath.regrasBasicas,
                textButton: AppLocalizations.of(context)!.button_basic_rules,
                routeButton: '/BasicRules'), // <- '/basicrules'
            ButtonOptionsRules(
                imageButton: AppIconsPath.cbjjRules,
                textButton: AppLocalizations.of(context)!.button_cbjj_Rules,
                routeButton: '/CbjjRules'), //' <- /cbjjrules'),
          ],
        ),
      ),
    );
  }
}
