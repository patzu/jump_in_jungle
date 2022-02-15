import 'package:bitcoin_girl/game/warrior_girl_game.dart';
import 'package:flutter/cupertino.dart';

class GameModel extends ChangeNotifier {
  late WarriorGirlGame gameRef;
  GameStateEnum _state = GameStateEnum.pause;

  //This is the private constructor for GameModel class
  GameModel._privateConstructor();

  //Creating a unique reference to the same object
  static final GameModel instance = GameModel._privateConstructor();

  // initializing gameRef variable using factory
  factory GameModel({required WarriorGirlGame gameRef}) {
    instance.gameRef = gameRef;
    return instance;
  }


  GameStateEnum get state => _state;

  set state(GameStateEnum value) {
    _state = value;
    notifyListeners();
  }

  bool isPaused() {
    if (state == GameStateEnum.pause) {
      return true;
    } else {
      return false;
    }
  }

  bool isResumed() {
    if (state == GameStateEnum.resume) {
      return true;
    } else {
      return false;
    }
  }

  pauseGameEngine() {
    state = GameStateEnum.pause;
    gameRef.pauseEngine();
  }

  resumeGameEngine() {
    state = GameStateEnum.resume;
    gameRef.resumeEngine();
  }
}

enum GameStateEnum {
  gameOver,
  win,
  pause,
  resume,
}
