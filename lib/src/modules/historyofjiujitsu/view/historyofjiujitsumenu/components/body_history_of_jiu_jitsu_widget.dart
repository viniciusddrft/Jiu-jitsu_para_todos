import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
              imageButton: AppIconsPath.india,
              textButton:
                  AppLocalizations.of(context)!.button_origin_of_jiujitsu,
              routeButton: '/OriginOfJiujitsu',
            ),
            ButtonOptionsHistory(
              imageButton: AppIconsPath.brasil,
              textButton:
                  AppLocalizations.of(context)!.button_jiujitsu_in_brazil,
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
