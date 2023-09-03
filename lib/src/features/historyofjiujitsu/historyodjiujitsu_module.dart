import 'package:flutter_modular/flutter_modular.dart';
import 'ui/historyofjiujitsumenu/history_of_jiu_jitsu_page.dart';
import 'ui/jiujitsuinbrazil/jiu_jitsu_in_brazil_view.dart';
import 'ui/originofjiujitsu/origin_of_jiu_jitsu_view.dart';

class HistoryOfJiujitsuModule extends Module {
  @override
  void routes(r) {
    r.child('/historyojiujitsu',
        child: (context) => const HistoryOfJiuJitsuPage(),
        transition: TransitionType.rightToLeft);
    r.child('/jiujitsuinbrazil',
        child: (context) => const JiujitsuinBrazilPage(),
        transition: TransitionType.rightToLeft);
    r.child('/originofjiujitsu',
        child: (context) => const OriginOfJiujitsuPage(),
        transition: TransitionType.rightToLeft);
  }
}
