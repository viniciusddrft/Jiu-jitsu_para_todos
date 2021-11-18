import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:jiu_jitsu_para_todos/src/modules/historyofjiujitsu/view/historyofjiujitsumenu/components/components/button_options_history_widget.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_icons_path.dart';

class BodyHistoryOfJiuJistu extends StatelessWidget {
  const BodyHistoryOfJiuJistu({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ButtonOptionsHistory(
              imageButtonOptionsHistory: AppIconsPath.india,
              textButtonOptionsHistory: 'button_origin_of_jiujitsu'.tr(),
              routeButton: '/OriginOfJiujitsu',
            ),
            ButtonOptionsHistory(
              imageButtonOptionsHistory: AppIconsPath.brasil,
              textButtonOptionsHistory: 'button_jiujitsu_in_brazil'.tr(),
              routeButton: '/JiujitsuInBrazil',
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
