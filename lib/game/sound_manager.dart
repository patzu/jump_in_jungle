import 'package:flame_audio/flame_audio.dart';

class SoundManager {
  static void playHurtSound() {
    FlameAudio.audioCache.play('hurt7.wav');
  }
}
