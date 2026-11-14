import 'package:flutter_modular/flutter_modular.dart';
import '../../shared/transitions/app_transitions.dart';
import 'interactor/settings_interactor.dart';
import 'ui/settings_page.dart';

final settingsModule = createModule(
  path: '/settings',
  register: (c) => c
    ..add(SettingsInteractor.new)
    ..route('/settings',
        child: (context, state) => const SettingsPage(),
        transition: AppTransitions.rightToLeft),
);
