import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../shared/appbar_gradient/appbar_gradient.dart';
import '../../../shared/mixins/device_orientation.dart';
import '../../../shared/themes/app_colors.dart';

import 'components/components/clock_widget.dart';
import 'components/components/scoreboard_widget.dart';

class FightMakerView extends StatefulWidget {
  const FightMakerView({super.key});

  @override
  State<FightMakerView> createState() => _FightMakerViewState();
}

class _FightMakerViewState extends State<FightMakerView>
    with DeviceOrientationApp {
  late final Future<void> _loadConfigs;

  @override
  void initState() {
    _loadConfigs = configLandscape();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const AppBarGradient(),
        title: Text(AppLocalizations.of(context)!.title_appbar_fightmarker_page,
            style: GoogleFonts.yatraOne()),
      ),
      backgroundColor: AppColors.background,
      body: FutureBuilder(
        future: _loadConfigs,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) =>
            snapshot.connectionState == ConnectionState.done
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
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
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
      ),
    );
  }
}
