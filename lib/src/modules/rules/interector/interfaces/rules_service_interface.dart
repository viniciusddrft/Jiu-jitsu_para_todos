import 'package:jiu_jitsu_para_todos/src/modules/rules/interector/rules_state.dart';

abstract interface class RulesServiceInterface {
  Future<RulesState> downloadPDf(String url, String name);
}
