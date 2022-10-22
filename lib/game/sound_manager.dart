import 'package:flame_audio/flame_audio.dart';

class SoundManager {
  static void playHurtSound() {
    FlameAudio.play('hurt7.wav');
  }

  static void playJumpAudio() {
    FlameAudio.play('jump14.wav');
  }

  static void playBackgroundMusic() {
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play('bgmj.mp3');
  }

  static void pauseBackgroundMusic() {
    FlameAudio.bgm.pause();
  }

  static void resumeBackgroundMusic() {
    FlameAudio.bgm.resume();
  }
  static void stopBackgroundMusic(){
    FlameAudio.bgm.stop();
  }
}
