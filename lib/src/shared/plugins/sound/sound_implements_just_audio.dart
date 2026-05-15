import 'package:just_audio/just_audio.dart';

import 'interface/sound_interface.dart';

class JustAudio implements SoundInterface {
  final _audioPlayer = AudioPlayer();

  @override
  void dispose() => _audioPlayer.dispose();

  @override
  Future<void> play(String soundPath) async {
    try {
      await _audioPlayer.setAsset(soundPath);
      await _audioPlayer.play();
    } on PlayerInterruptedException {
      // Som substituído por outro / player liberado — esperado, ignorar.
    } catch (_) {
      // Outros erros de áudio são silenciados para não derrubar o fluxo.
    }
  }

  @override
  void stop() => _audioPlayer.stop();

  @override
  void pause() => _audioPlayer.pause();
}
