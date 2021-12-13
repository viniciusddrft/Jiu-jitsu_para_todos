import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiu_jitsu_para_todos/src/modules/fightmarker/view/components/body_fight_marker_widget.dart';
import 'package:jiu_jitsu_para_todos/src/shared/appbar_gradient/appbar_gradient.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';
import 'package:wakelock/wakelock.dart';

class FightMakerView extends StatefulWidget {
  const FightMakerView({Key? key}) : super(key: key);

  @override
  State<FightMakerView> createState() => _FightMakerViewState();
}

class _FightMakerViewState extends State<FightMakerView> {
  @override
  void initState() {
    Wakelock.enable();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const AppBarGradient(),
        title: Text(AppLocalizations.of(context)!.title_appbar_fightmarker_page,
            style: const TextStyle(fontFamily: 'YatraOne')),
      ),
      backgroundColor: AppColors.background,
      body: const BodyFightMarker(),
    );
  }
}
