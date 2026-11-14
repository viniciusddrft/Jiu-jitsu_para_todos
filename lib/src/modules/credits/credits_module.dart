import 'package:flutter_modular/flutter_modular.dart';
import '../../shared/transitions/app_transitions.dart';
import 'ui/credits.dart';

final creditsModule = createModule(
  path: '/credits',
  register: (c) => c.route(
    '/credits',
    child: (context, state) => const CreditsPage(),
    transition: AppTransitions.downToUp,
  ),
);
