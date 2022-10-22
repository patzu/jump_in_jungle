import 'package:bitcoin_girl/game/sound_manager.dart';
import 'package:bitcoin_girl/game/warrior_girl_game.dart';
import 'package:flutter/cupertino.dart';

class GameModel extends ChangeNotifier {
  late WarriorGirlGame gameRef;
  GameStateEnum _gameState = GameStateEnum.pause;
  PlayerStateEnum _playerState = PlayerStateEnum.alive;

  //Private constructor for GameModel class
  GameModel._privateConstructor();

  //Creating a unique reference to the same object
  static final GameModel instance = GameModel._privateConstructor();

  // initializing gameRef variable using factory
  factory GameModel({required WarriorGirlGame gameRef}) {
    instance.gameRef = gameRef;
    return instance;
  }

  GameStateEnum get gameState => _gameState;

  set gameState(GameStateEnum value) {
    _gameState = value;
    notifyListeners();
  }

  PlayerStateEnum get playerState => _playerState;

  set playerState(PlayerStateEnum value) {
    _playerState = value;
    notifyListeners();
    print('player state changed to:' + playerState.name);
  }

  bool isPaused() {
    if (gameState == GameStateEnum.pause) {
      return true;
    } else {
      return false;
    }
  }

  bool isResumed() {
    if (gameState == GameStateEnum.resume) {
      return true;
    } else {
      return false;
    }
  }

  bool isDead() {
    if (playerState == PlayerStateEnum.dead) {
      return true;
    } else {
      return false;
    }
  }

  pauseGameEngine() {
    gameState = GameStateEnum.pause;
    gameRef.pauseEngine();
    SoundManager.pauseBackgroundMusic();
  }

  resumeGameEngine() {
    gameState = GameStateEnum.resume;
    gameRef.resumeEngine();
    SoundManager.resumeBackgroundMusic();
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
