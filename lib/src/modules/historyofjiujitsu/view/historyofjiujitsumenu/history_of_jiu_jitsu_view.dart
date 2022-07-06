import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../shared/appbar_gradient/appbar_gradient.dart';
import '../../../../shared/themes/app_colors.dart';
import '../../../../shared/themes/app_icons_path.dart';

import 'components/button_options_history_widget.dart';

class HistoryOfJiuJitsuView extends StatelessWidget {
  const HistoryOfJiuJitsuView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const AppBarGradient(),
        title: Text(
            AppLocalizations.of(context)!.title_appbar_history_of_jiujitsu_page,
            style: const TextStyle(fontFamily: 'YatraOne')),
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
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
