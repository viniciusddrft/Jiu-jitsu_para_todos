import 'package:just_audio/just_audio.dart';

import 'interface/sound_interface.dart';

class JustAudio implements SoundInterface {
  final _audioPlayer = AudioPlayer();

  @override
  void dispose() => _audioPlayer.dispose();

  @override
  Future<void> play(String soundPath) =>
      _audioPlayer.setAsset(soundPath).then((_) => _audioPlayer.play());

  @override
  void stop() => _audioPlayer.stop();

  @override
  void pause() => _audioPlayer.pause();
}
