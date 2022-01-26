import 'package:dinogame/girl.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

class WarriorGirlGame extends FlameGame with TapDetector{
  bool firstTap = true;
  late GirlSprites girlSprites;

  @override
  Future<void>? onLoad() async {
    playBackgroundMusic();
    girlSprites = GirlSprites(this)..size = Vector2(100, 100);

    final parallax = await backgroundParallaxComponent();
    add(parallax);

    add(girlSprites);

    return super.onLoad();
  }

  void playBackgroundMusic() {
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play('bgm.mp3');
  }

  @override
  void onTapDown(TapDownInfo info) {
    if (firstTap) {
      girlSprites.idle();
      firstTap = false;
    } else {
      girlSprites.jump();
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
