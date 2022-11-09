import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jungler/game/jungler_game.dart';
import 'package:jungler/notifiers/sound_manager_notifier.dart';

part 'game_notifier.freezed.dart';

final gameProvider = StateNotifierProvider<GameNotifier, GameState>((ref) {
  return GameNotifier(ref);
});

@freezed
class GameState with _$GameState {
  const factory GameState({
    JunglerGame? gameRef,
    @Default(GameStateEnum.pause) GameStateEnum gameState,
    @Default(PlayerStateEnum.alive) PlayerStateEnum playerState,
  }) = _GameState;
}

class GameNotifier extends StateNotifier<GameState> {
  Ref ref;
  late final soundManagerStateRead;

  GameNotifier(
    this.ref,
  ) : super(GameState()) {
    soundManagerStateRead = ref.read(soundManagerProvider.notifier);
  }

  setPlayerState(PlayerStateEnum playerState) {
    state = state.copyWith(playerState: playerState);
  }

  PlayerStateEnum getPlayerState() {
    return state.playerState;
  }

  setGameState(GameStateEnum gameState) {
    state = state.copyWith(gameState: gameState);
  }

  getGameState() {
    return state.gameState;
  }

  setGameRef(JunglerGame gameRef) {
    state = state.copyWith(gameRef: gameRef);
  }

  bool isPaused() {
    if (state.gameState == GameStateEnum.pause) {
      return true;
    } else {
      return false;
    }
  }

  bool isResumed() {
    if (state.gameState == GameStateEnum.resume) {
      return true;
    } else {
      return false;
    }
  }

  bool isDead() {
    if (state.playerState == PlayerStateEnum.dead) {
      return true;
    } else {
      return false;
    }
  }

  pauseGameEngine() {
    state = state.copyWith(gameState: GameStateEnum.pause);
    state.gameRef?.pauseEngine();
  }

  resumeGameEngine() {
    state = state.copyWith(gameState: GameStateEnum.resume);
    state.gameRef?.resumeEngine();
  }
}

enum GameStateEnum {
  pause,
  resume,
}

enum PlayerStateEnum {
  dead,
  alive,
}
