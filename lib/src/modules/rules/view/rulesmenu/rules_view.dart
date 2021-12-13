import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/modules/rules/view/rulesmenu/components/body_rules_widget.dart';
import 'package:jiu_jitsu_para_todos/src/shared/appbar_gradient/appbar_gradient.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';

class RulesView extends StatelessWidget {
  const RulesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const AppBarGradient(),
        title: Text(AppLocalizations.of(context)!.title_appbar_rule_page,
            style: const TextStyle(fontFamily: 'YatraOne')),
      ),
      backgroundColor: AppColors.background,
      body: const BodyRules(),
    );
  }
}
