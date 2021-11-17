import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/modules/rules/view/rulesmenu/components/components/button_options_rules_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_icons_path.dart';

class BodyRules extends StatelessWidget {
  const BodyRules();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ButtonOptionsRules(
                imageButton: AppIconsPath.regrasBasicas,
                textButton: 'button_basic_rules'.tr(),
                routeButton: '/BasicRules'), // <- '/basicrules'
            ButtonOptionsRules(
                imageButton: AppIconsPath.cbjjRules,
                textButton: 'button_cbjj_Rules'.tr(),
                routeButton: '/CbjjRules'), //' <- /cbjjrules'),
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            )
          ],
        ),
      ),
    );
  }
}
