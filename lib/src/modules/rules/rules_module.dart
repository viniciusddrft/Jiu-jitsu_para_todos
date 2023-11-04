import 'package:flutter_modular/flutter_modular.dart';
import 'ui/basicrules/basic_rules_view.dart';
import 'ui/cbjjrules/cbjj_rules_view.dart';
import 'ui/rulesmenu/rules_view.dart';

class RulesModule extends Module {
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
