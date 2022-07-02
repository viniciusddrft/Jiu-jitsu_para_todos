import 'package:just_audio/just_audio.dart';

import 'interface/service_sound_interface.dart';

class ServiceJustAudio implements ServiceSoundInterface {
  final AudioPlayer _audioPlayer = AudioPlayer();

  ServiceJustAudio();

  @override
  void dispose() => _audioPlayer.dispose();

  @override
  void play(String soundPath) =>
      _audioPlayer.setAsset(soundPath).then((_) => _audioPlayer.play());

  @override
  void stop() => _audioPlayer.stop();
}
