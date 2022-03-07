import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/modules/rules/view/rulesmenu/components/components/button_options_rules_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_icons_path.dart';

class BodyRules extends StatelessWidget {
  const BodyRules({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return SizedBox(
      height: _size.height,
      width: _size.height,
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
