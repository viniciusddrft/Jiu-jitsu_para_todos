import 'package:jiu_jitsu_para_todos/src/shared/plugins/interface_plugin_sound.dart';
import 'package:just_audio/just_audio.dart';

class PluginJustAudio implements InterfacePluginSound {
  final AudioPlayer _audioPlayer = AudioPlayer();

  PluginJustAudio();

  @override
  void dispose() => _audioPlayer.dispose();

  @override
  void play(String soundpath) =>
      _audioPlayer.setAsset(soundpath).then((_) => _audioPlayer.play());

  @override
  void stop() => _audioPlayer.stop();
}
