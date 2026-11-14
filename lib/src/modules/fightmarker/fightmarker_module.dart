import 'package:flutter_modular/flutter_modular.dart';
import '../../shared/plugins/sound/interface/sound_interface.dart';
import '../../shared/plugins/sound/sound_implements_just_audio.dart';
import '../../shared/transitions/app_transitions.dart';
import 'interactor/clock_interactor.dart';
import 'interactor/scorreboard_interactor.dart';
import 'ui/fightmarker_page.dart';

final fightmakerModule = createModule(
  path: '/fightmaker',
  register: (c) => c
    ..add<SoundInterface>(JustAudio.new)
    ..add(ScoreboardInteractor.new)
    ..add(ClockInteractor.new)
    ..route(
      '/fightmaker',
      child: (context, state) => const FightMakerPage(),
      transition: AppTransitions.downToUp,
    ),
);
