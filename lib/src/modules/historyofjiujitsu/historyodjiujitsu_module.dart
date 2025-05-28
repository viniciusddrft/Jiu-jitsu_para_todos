import 'package:flutter_modular/flutter_modular.dart';
import 'package:jiu_jitsu_para_todos/src/modules/historyofjiujitsu/ui/jiujitsuinjapan/jiujitsu_in_japan_view.dart';
import 'ui/historyofjiujitsumenu/history_of_jiu_jitsu_page.dart';
import 'ui/jiujitsuinbrazil/jiu_jitsu_in_brazil_view.dart';
import 'ui/jiujitsuinindia/jiujitsu_in_india_view.dart';

class HistoryOfJiujitsuModule extends Module {
  @override
  void routes(r) {
    r.child('/historyojiujitsu',
        child: (context) => const HistoryOfJiuJitsuPage(),
        transition: TransitionType.rightToLeft);
    r.child('/jiujitsuinbrazil',
        child: (context) => const JiujitsuinBrazilPage(),
        transition: TransitionType.rightToLeft);
    r.child('/jiujitsuinindia',
        child: (context) => const JiujitsuInIndiaView(),
        transition: TransitionType.rightToLeft);
    r.child('/jiujitsuinjapan',
        child: (context) => const JiujitsuInJapanView(),
        transition: TransitionType.rightToLeft);
  }
}
