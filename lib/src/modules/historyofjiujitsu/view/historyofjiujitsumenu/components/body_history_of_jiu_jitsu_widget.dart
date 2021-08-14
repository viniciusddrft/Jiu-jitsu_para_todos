import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:jiu_jitsu_para_todos/src/modules/historyofjiujitsu/view/historyofjiujitsumenu/components/button_options_history_widget.dart';
import 'package:jiu_jitsu_para_todos/src/modules/historyofjiujitsu/view/jiujitsuinbrazil/jiu_jitsu_in_brazil_view.dart';
import 'package:jiu_jitsu_para_todos/src/modules/historyofjiujitsu/view/originofjiujitsu/origin_of_jiu_jitsu_view.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_icons_path.dart';

class BodyHistoryOfJiuJistu extends StatelessWidget {
  const BodyHistoryOfJiuJistu();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            BottonOptionsHistory(
              imageButton: AppIconsPath.india,
              textButton: 'button_origin_of_jiujitsu'.tr(),
              routeButton: OriginOfJiujitsu(),
            ),
            BottonOptionsHistory(
              imageButton: AppIconsPath.brasil,
              textButton: 'button_jiujitsu_in_brazil'.tr(),
              routeButton: JiujitsuinBrazil(),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            )
          ],
        ),
      ),
    );
  }
}
