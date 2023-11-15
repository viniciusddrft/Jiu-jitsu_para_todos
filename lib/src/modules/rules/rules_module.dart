import 'package:flutter_modular/flutter_modular.dart';
import 'package:jiu_jitsu_para_todos/src/modules/rules/data/rules_service_impl.dart';
import 'package:jiu_jitsu_para_todos/src/modules/rules/interector/interfaces/rules_service_interface.dart';
import 'package:jiu_jitsu_para_todos/src/modules/rules/interector/rules_interector.dart';
import 'ui/basicrules/basic_rules_view.dart';
import 'ui/cbjjrules/cbjj_rules_view.dart';
import 'ui/rulesmenu/rules_view.dart';

class RulesModule extends Module {
  @override
  void binds(i) {
    i.add(RulesInterector.new);
    i.add<RulesServiceInterface>(RulesServiceImpl.new);
  }

  @override
  void routes(r) {
    r.child('/rules',
        child: (context) => const RulesPage(),
        transition: TransitionType.rightToLeft);
    r.child('/cbjjrules',
        child: (context) => const CbjjrulesPage(),
        transition: TransitionType.rightToLeft);
    r.child('/basicrules',
        child: (context) => const BasicRulesPage(),
        transition: TransitionType.rightToLeft);
  }
}
