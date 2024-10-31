import 'package:flutter_modular/flutter_modular.dart';
import '../../shared/plugins/sound/interface/sound_interface.dart';
import '../../shared/plugins/sound/sound_implements_just_audio.dart';
import 'interactor/clock_interactor.dart';
import 'interactor/scorreboard_interactor.dart';
import 'ui/fightmarker_page.dart';

class FightmakerModule extends Module {
  @override
  void binds(i) {
    i.add<SoundInterface>(JustAudio.new);
    i.add(ScoreboardInteractor.new);
    i.add(ClockInteractor.new);
  }

  @override
  void routes(r) {
    r.child('/fightmaker',
        child: (context) => const FightMakerPage(),
        transition: TransitionType.downToUp);
  }
}
