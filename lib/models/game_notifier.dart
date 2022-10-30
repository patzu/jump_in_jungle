import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../game/sound_manager_notifier.dart';
import '../game/warrior_girl_game.dart';

part 'game_notifier.freezed.dart';

final gameProvider = StateNotifierProvider<GameNotifier, GameState>((ref) {
  return GameNotifier(ref);
});

@freezed
class GameState with _$GameState {
  const factory GameState({
    WarriorGirlGame? gameRef,
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

  GameStateEnum getGameState() {
    return state.gameState;
  }

  setGameRef(WarriorGirlGame gameRef) {
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
    print('game state is: ${state.gameState}');
    soundManagerStateRead.pauseBackgroundMusic();
    state.gameRef?.pauseEngine();
  }

  resumeGameEngine() {
    state = state.copyWith(gameState: GameStateEnum.resume);
    print('game state is: ${state.gameState}');
    state.gameRef?.resumeEngine();
    soundManagerStateRead.resumeBackgroundMusic();
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
