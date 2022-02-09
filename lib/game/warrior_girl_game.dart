import 'package:bitcoin_girl/models/score_model.dart';
import 'package:bitcoin_girl/widgets/score_overlay.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import 'enemy.dart';
import 'enemy_manager.dart';
import 'girl_sprite.dart';

class WarriorGirlGame extends FlameGame with TapDetector, HasCollidables {
  bool isFirstTap = true;
  late GirlSprites girlSprites;
  double score = 0.0;
  late TextComponent scoreText;

  ScoreModel scoreModel;

  WarriorGirlGame(this.scoreModel);

  @override
  Future<void>? onLoad() async {
    // playBackgroundMusic();

    girlSprites = GirlSprites(this, scoreModel);
    add(girlSprites..size = Vector2(40, 40));

    final parallax = await backgroundParallaxComponent();
    add(parallax);

    add(EnemyManager());

    scoreText = TextComponent(
      text: '$score',
      position: Vector2(300, 5),
    );

    add(scoreText);

    overlays.add(ScoreOverlay.id);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    score += (50 * dt);
    scoreText.text = score.toInt().toString();

    super.update(dt);
  }

  void playBackgroundMusic() {
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play('bgmj.mp3');
  }

  @override
  void onTapDown(TapDownInfo info) {
    if (isFirstTap) {
      girlSprites.run();
      isFirstTap = false;
    } else {
      girlSprites.jump();
      girlSprites.run();
    }
  }

  Future<ParallaxComponent<FlameGame>> backgroundParallaxComponent() async {
    return ParallaxComponent(
      parallax: Parallax(
        await Future.wait([
          loadParallaxLayer(
            ParallaxImageData('parallax/plx-1.png'),
          ),
          loadParallaxLayer(
            ParallaxImageData('parallax/plx-2.png'),
            velocityMultiplier: Vector2(1.1, 0),
          ),
          loadParallaxLayer(
            ParallaxImageData('parallax/plx-3.png'),
            velocityMultiplier: Vector2(1.3, 0),
          ),
          loadParallaxLayer(
            ParallaxImageData('parallax/plx-4.png'),
            velocityMultiplier: Vector2(1.6, 0),
          ),
          loadParallaxLayer(
            ParallaxImageData('parallax/plx-5.png'),
            velocityMultiplier: Vector2(3, 0),
          ),
          loadParallaxLayer(
            ParallaxImageData('parallax/plx-6.png'),
            velocityMultiplier: Vector2(1.8, 0),
            alignment: Alignment.bottomCenter,
            fill: LayerFill.none,
          ),
        ]),
        baseVelocity: Vector2(20, 0),
      ),
    );
  }
}

enum GameStateEnum {
  fail,
  win,
  start,
  stop,
  running,
}

class GameState {
  static GameStateEnum _gameState = GameStateEnum.stop;

  static set gameState(GameStateEnum value) {
    _gameState = value;
  }

  static stop() {
    if (_gameState == GameStateEnum.stop) {
      return true;
    } else {
      return false;
    }
  }

  static start() {
    if (_gameState == GameStateEnum.start) {
      return true;
    } else {
      return false;
    }
  }
}
