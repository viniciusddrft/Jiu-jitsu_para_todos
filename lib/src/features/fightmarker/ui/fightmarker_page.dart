import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../shared/mixins/device_orientation.dart';
import '../../../shared/themes/app_colors.dart';
import 'components/clock_widget.dart';
import 'components/score_board_widget.dart';

class FightMakerPage extends StatefulWidget {
  const FightMakerPage({super.key});

  @override
  State<FightMakerPage> createState() => _FightMakerPageState();
}

class _FightMakerPageState extends State<FightMakerPage>
    with DeviceOrientationApp {
  @override
  void initState() {
    configLandscape();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          AppLocalizations.of(context)!.title_appbar_fightmarker_page,
          style: GoogleFonts.yatraOne(),
        ),
      ),
      backgroundColor: AppColors.background,
      body: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 2,
            child: Scoreboard(),
          ),
          Flexible(
            child: Clock(),
          ),
          Flexible(
            flex: 2,
            child: Scoreboard(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    configPortrait();
    super.dispose();
  }
}
