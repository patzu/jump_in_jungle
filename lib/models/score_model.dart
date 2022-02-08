import 'package:flutter/cupertino.dart';

class ScoreModel with ChangeNotifier {
  int _highScore = 0;
  int _score = 0;
  int _lives = 5;

  int get highScore => _highScore;

  set highScore(int value) {
    _highScore = value;
    notifyListeners();
  }

  int get score => _score;

  set score(int value) {
    _score = value;
    notifyListeners();
  }

  int get lives => _lives;

  set lives(int value) {
    _lives = value;
    print('scoreModel.live: $_lives');
    notifyListeners();
  }
}
