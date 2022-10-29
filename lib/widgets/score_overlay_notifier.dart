import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'score_overlay_notifier.freezed.dart';

final scoreOverlayProvider =
    StateNotifierProvider<ScoreOverlayNotifier, ScoreOverlayState>(
        (ref) => ScoreOverlayNotifier());

@freezed
class ScoreOverlayState with _$ScoreOverlayState {
  const factory ScoreOverlayState({
    @Default(0) int highScore,
    @Default(0) int score,
    @Default(5) int lives,
  }) = _ScoreOverlayState;
}

class ScoreOverlayNotifier extends StateNotifier<ScoreOverlayState> {
  ScoreOverlayNotifier() : super(ScoreOverlayState());

  setScore(int score) {
    state = state.copyWith(score: score);
  }

  int getScore() {
    return state.score;
  }

  setLives(int lives) {
    state = state.copyWith(lives: lives);
  }

  int getLives() {
    return state.lives;
  }

  addScoreByOne() {
    state = state.copyWith(score: state.score + 1);
  }

  subtractScoreByOne() {
    state = state.copyWith(score: state.score - 1);
  }

  addLivesByOne() {
    state = state.copyWith(lives: state.lives + 1);
  }

  livesReducerByOne() {
    state = state.copyWith(lives: state.lives - 1);
  }

  setHighScore(int highScore) {
    state = state.copyWith(highScore: highScore);
  }
}
