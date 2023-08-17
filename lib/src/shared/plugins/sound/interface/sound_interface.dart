abstract interface class SoundInterface {
  const SoundInterface();
  void dispose();
  void play(String soundPath);
  void stop();
}
