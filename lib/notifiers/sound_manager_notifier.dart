import 'package:flame_audio/flame_audio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sound_manager_notifier.freezed.dart';

@freezed
class SoundManagerState with _$SoundManagerState {
  const factory SoundManagerState({
    @Default(false) bool isBackgroundMusicPlaying,
    @Default(true) bool isHurtSoundPlaying,
    @Default(true) bool isJumpSoundPlaying,
  }) = _SoundManagerState;
}

class SoundManagerNotifier extends StateNotifier<SoundManagerState> {
  SoundManagerNotifier() : super(SoundManagerState());

  setIsHurtSoundPlaying(bool value) {
    state = state.copyWith(isHurtSoundPlaying: value);
  }

  setIsJumpSoundPlaying(bool value) {
    state = state.copyWith(isJumpSoundPlaying: value);
  }

  void playHurtSound() {
    if (state.isHurtSoundPlaying) {
      FlameAudio.play('hurt7.wav');
    }
  }

  void playJumpAudio() {
    if (state.isJumpSoundPlaying) {
      FlameAudio.play('jump14.wav');
    }
  }

  void playBackgroundMusic() {
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play('bgmj.mp3');
    state = state.copyWith(isBackgroundMusicPlaying: true);
  }

  void pauseBackgroundMusic() {
    FlameAudio.bgm.pause();
    state = state.copyWith(isBackgroundMusicPlaying: false);
  }

  void resumeBackgroundMusic() {
    FlameAudio.bgm.resume();
    state = state.copyWith(isBackgroundMusicPlaying: true);
  }

  void stopBackgroundMusic() {
    FlameAudio.bgm.stop();
    state = state.copyWith(isBackgroundMusicPlaying: false);
  }
}

final soundManagerProvider =
    StateNotifierProvider<SoundManagerNotifier, SoundManagerState>(
  (ref) => SoundManagerNotifier(),
);
