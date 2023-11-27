import 'package:flutter_modular/flutter_modular.dart';
import 'package:jiu_jitsu_para_todos/src/modules/settings/ui/settings_page.dart';
import 'interector/settings_interector.dart';

class SettingsModule extends Module {
  @override
  void binds(i) {
    i.add(SettingsInterector.new);
  }

  @override
  void routes(r) {
    r.child('/settings',
        child: (context) => const SettingsPage(),
        transition: TransitionType.rightToLeft);
  }
}
