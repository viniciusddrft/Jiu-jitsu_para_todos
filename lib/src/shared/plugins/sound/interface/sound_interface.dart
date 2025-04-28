abstract interface class SoundInterface {
  const SoundInterface();
  void dispose();
  Future<void> play(String soundPath);
  void stop();
  void pause();
}
