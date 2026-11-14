import 'package:flutter_modular/flutter_modular.dart';
import '../../shared/transitions/app_transitions.dart';
import 'ui/historyofjiujitsumenu/history_of_jiu_jitsu_page.dart';
import 'ui/jiujitsuinbrazil/jiu_jitsu_in_brazil_view.dart';
import 'ui/jiujitsuinindia/jiujitsu_in_india_view.dart';
import 'ui/jiujitsuinjapan/jiujitsu_in_japan_view.dart';

final historyOfJiujitsuModule = createModule(
  path: '/historyojiujitsu',
  register: (c) => c
    ..route('/historyojiujitsu',
        child: (context, state) => const HistoryOfJiuJitsuPage(),
        transition: AppTransitions.rightToLeft)
    ..route('/jiujitsuinbrazil',
        child: (context, state) => const JiujitsuinBrazilPage(),
        transition: AppTransitions.rightToLeft)
    ..route('/jiujitsuinindia',
        child: (context, state) => const JiujitsuInIndiaView(),
        transition: AppTransitions.rightToLeft)
    ..route('/jiujitsuinjapan',
        child: (context, state) => const JiujitsuInJapanView(),
        transition: AppTransitions.rightToLeft),
);
