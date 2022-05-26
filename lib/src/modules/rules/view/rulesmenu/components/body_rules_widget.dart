import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../shared/themes/app_icons_path.dart';
import 'components/button_options_rules_widget.dart';

class BodyRules extends StatelessWidget {
  const BodyRules({super.key});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      width: size.height,
      child: SingleChildScrollView(
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
