import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiu_jitsu_para_todos/src/shared/appbar_gradient/appbar_gradient.dart';
import 'package:jiu_jitsu_para_todos/src/views/historyofjiujitsu/historyofjiujitsumenu/components/body_history_of_jiu_jitsu_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class HistoryOfJiuJitsuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: AppBarGradient(),
        title: Text('title_appbar_history_of_jiujitsu_page'.tr(),
            style: TextStyle(fontFamily: 'YatraOne')),
      ),
      backgroundColor: Color(0xff202848),
      body: BodyHistoryOfJiuJistu(),
    );
  }
}
