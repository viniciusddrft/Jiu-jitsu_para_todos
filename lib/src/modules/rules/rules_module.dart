import 'package:flutter_modular/flutter_modular.dart';
import '../../shared/transitions/app_transitions.dart';
import 'data/rules_service_impl.dart';
import 'interactor/interfaces/rules_service_interface.dart';
import 'interactor/rules_interactor.dart';
import 'ui/basicrules/basic_rules_view.dart';
import 'ui/cbjjrules/cbjj_rules_view.dart';
import 'ui/rulesmenu/rules_view.dart';

final rulesModule = createModule(
  path: '/rules',
  register: (c) => c
    ..add(RulesInteractor.new)
    ..add<RulesServiceInterface>(RulesServiceImpl.new)
    ..route('/rules',
        child: (context, state) => const RulesPage(),
        transition: AppTransitions.rightToLeft)
    ..route('/cbjjrules',
        child: (context, state) => const CbjjrulesPage(),
        transition: AppTransitions.rightToLeft)
    ..route('/basicrules',
        child: (context, state) => const BasicRulesPage(),
        transition: AppTransitions.rightToLeft),
);
