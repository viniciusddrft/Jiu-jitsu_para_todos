import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_ui/material_ui.dart';

import '../../../shared/l10n/app_localizations.dart';
import '../../../shared/mixins/device_orientation.dart';
import '../../../shared/themes/app_colors.dart';
import '../../../shared/themes/app_text_styles.dart';
import '../interactor/scorreboard_interactor.dart';
import 'components/clock_widget.dart';
import 'components/score_board_widget.dart';

/// Marcador de luta (em paisagem): Atleta 1 | relógio | Atleta 2.
class FightMakerPage extends StatefulWidget {
  const FightMakerPage({super.key});

  @override
  State<FightMakerPage> createState() => _FightMakerPageState();
}

class _FightMakerPageState extends State<FightMakerPage>
    with DeviceOrientationApp {
  // A página é dona dos dois placares: cada cartão mostra o seu e o relógio
  // recebe os dois para exibir o resultado no fim do tempo.
  final _athlete1 = inject<ScoreboardInteractor>();
  final _athlete2 = inject<ScoreboardInteractor>();

  @override
  void initState() {
    configLandscape();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 12, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  flex: 5,
                  child: Scoreboard(
                      athlete: 1, interactor: _athlete1, light: true)),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          tooltip: MaterialLocalizations.of(context)
                              .backButtonTooltip,
                          onPressed: () => Navigator.of(context).maybePop(),
                          icon: const Icon(Icons.arrow_back_rounded,
                              color: AppColors.text),
                        ),
                        Expanded(
                          child: Text(
                            l10n.title_appbar_fightmarker_page.toUpperCase(),
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.eyebrow(),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                        child: Clock(athletes: (_athlete1, _athlete2))),
                  ],
                ),
              ),
              Expanded(
                  flex: 5,
                  child: Scoreboard(athlete: 2, interactor: _athlete2)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    configPortrait();
    _athlete1.dispose();
    _athlete2.dispose();
    super.dispose();
  }
}
