import 'package:flutter_modular/flutter_modular.dart';
import 'ui/credits.dart';

class CreditsModule extends Module {
  @override
  void routes(r) {
    r.child('/credits',
        child: (context) => const CreditsPage(),
        transition: TransitionType.downToUp);
  }
}
