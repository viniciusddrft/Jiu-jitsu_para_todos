import 'package:flutter_modular/flutter_modular.dart';
import '../../shared/plugins/sound/interface/sound_interface.dart';
import '../../shared/plugins/sound/sound_implements_just_audio.dart';
import 'interector/clock_interector.dart';
import 'interector/scorreboard_interector.dart';
import 'ui/fightmarker_page.dart';

class FightmakerModule extends Module {
  @override
  void binds(i) {
    i.add<SoundInterface>(JustAudio.new);
    i.add(ScoreboardInterector.new);
    i.add(ClockInterector.new);
  }

  @override
  void routes(r) {
    r.child('/fightmaker',
        child: (context) => const FightMakerPage(),
        transition: TransitionType.downToUp);
  }
}
