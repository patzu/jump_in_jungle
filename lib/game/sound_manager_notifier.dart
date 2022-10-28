import 'package:flame_audio/flame_audio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sound_manager_notifier.freezed.dart';

@freezed
class SoundManagerState with _$SoundManagerState {
  const factory SoundManagerState({
    @Default(false) bool bgmStatus,
  }) = _SoundManagerState;
}

class SoundManagerNotifier extends StateNotifier<SoundManagerState> {
  SoundManagerNotifier() : super(SoundManagerState());

  void playHurtSound() {
    FlameAudio.play('hurt7.wav');
  }

  void playJumpAudio() {
    FlameAudio.play('jump14.wav');
  }

  void playBackgroundMusic() {
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play('bgmj.mp3');
    state = state.copyWith(bgmStatus: true);
  }

  void pauseBackgroundMusic() {
    FlameAudio.bgm.pause();
    state = state.copyWith(bgmStatus: false);
  }

  void resumeBackgroundMusic() {
    FlameAudio.bgm.resume();
    state = state.copyWith(bgmStatus: true);
  }

  void stopBackgroundMusic() {
    FlameAudio.bgm.stop();
    state = state.copyWith(bgmStatus: false);
  }
}

final soundManagerProvider =
    StateNotifierProvider<SoundManagerNotifier, SoundManagerState>(
  (ref) => SoundManagerNotifier(),
);
