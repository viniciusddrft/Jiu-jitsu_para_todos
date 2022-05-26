import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../shared/themes/app_icons_path.dart';
import 'components/button_options_history_widget.dart';

class BodyHistoryOfJiuJistu extends StatelessWidget {
  const BodyHistoryOfJiuJistu({super.key});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.height,
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
          ],
        ),
      ),
    );
  }
}
