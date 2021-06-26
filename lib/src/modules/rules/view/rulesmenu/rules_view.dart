import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiu_jitsu_para_todos/src/modules/rules/view/rulesmenu/components/body_rules_widget.dart';
import 'package:jiu_jitsu_para_todos/src/shared/appbar_gradient/appbar_gradient.dart';
import 'package:easy_localization/easy_localization.dart';

class RulesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: AppBarGradient(),
        title: Text('title_appbar_rule_page'.tr(),
            style: TextStyle(fontFamily: 'YatraOne')),
      ),
      backgroundColor: Color(0xff202848),
      body: BodyRules(),
    );
  }
}
