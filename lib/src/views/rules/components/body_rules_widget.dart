import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/views/rules/basic_rules_view.dart';
import 'package:jiu_jitsu_para_todos/src/views/rules/components/botton_options_rules_widget.dart';
import 'package:jiu_jitsu_para_todos/src/views/rules/cbjj_rules_view.dart';
import 'package:easy_localization/easy_localization.dart';

class BodyRules extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            BottonOptionsRules(
                imagebotton: 'assets/images/iconsbutton/regrasbasicas.png',
                textbotton: 'button_basic_rules'.tr(),
                routebotton: Basicrules()), // <- '/basicrules'
            BottonOptionsRules(
                imagebotton: 'assets/images/iconsbutton/cbjjrules.png',
                textbotton: 'button_cbjj_Rules'.tr(),
                routebotton: Cbjjrules()), //' <- /cbjjrules'),
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            )
          ],
        ),
      ),
    );
  }
}
