import 'package:bitcoin_girl/game/player_data.dart';
import 'package:bitcoin_girl/game/sound_manager.dart';
import 'package:bitcoin_girl/models/game_model.dart';
import 'package:bitcoin_girl/widgets/score_overlay.dart';
import 'package:bitcoin_girl/widgets/score_overlay_model.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

import 'enemy_data.dart';
import 'enemy_manager.dart';
import 'girl_sprite.dart';

class WarriorGirlGame extends FlameGame
    with TapDetector, HasCollisionDetection {
  late GirlSprites girlSprites;
  double score = 0.0;
  ScoreOverlayModel scoreModel;

  WarriorGirlGame(this.scoreModel);

  final enemyManager = EnemyManager();

  @override
  Future<void>? onLoad() async {
    SoundManager.playBackgroundMusic();

    await images.loadAll(imageAssets);

    final parallax = await backgroundParallaxComponent();
    // final parallax = await plainParallaxComponent();
    add(parallax);

    final playerData = PlayerData();
    await playerData.init();

    girlSprites = GirlSprites(scoreModel, playerData);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (GameModel.instance.gameState == GameStateEnum.resume) {
      scoreModel.score += 1;
    }

    super.update(dt);
  }

  void startGame() {
    Future.delayed(Duration(seconds: 1)).then((value) {
      // SoundManager.playBackgroundMusic();
      GameModel.instance.playerState = PlayerStateEnum.alive;
      GameModel.instance.gameState = GameStateEnum.resume;

      overlays.add(ScoreOverlay.id);
      add(girlSprites..size = Vector2(40, 50));
      add(enemyManager);
      scoreModel.score = 0;
      scoreModel.lives = 5;
    });
  }

  void reset() {
    overlays.remove(ScoreOverlay.id);
    girlSprites.removeFromParent();
    enemyManager.removeAllEnemies();
    enemyManager.removeFromParent();
    // SoundManager.stopBackgroundMusic();
  }

  @override
  void onTapDown(TapDownInfo info) {
    if (!girlSprites.isDead && GameModel.instance.isResumed()) {
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

  Future<ParallaxComponent<FlameGame>> plainParallaxComponent() async {
    return ParallaxComponent(
      parallax: Parallax(
        await Future.wait([
          loadParallaxLayer(
            ParallaxImageData('parallax/plain/sheet1.png'),
          ),
          loadParallaxLayer(
            ParallaxImageData('parallax/plain/sheet2.png'),
            velocityMultiplier: Vector2(1.1, 0),
          ),
          loadParallaxLayer(
            ParallaxImageData('parallax/plain/sheet3.png'),
            velocityMultiplier: Vector2(1.3, 0),
          ),
          loadParallaxLayer(
            ParallaxImageData('parallax/plain/sheet4.png'),
            velocityMultiplier: Vector2(1.6, 0),
          ),
          loadParallaxLayer(
            ParallaxImageData('parallax/plain/sheet5.png'),
            velocityMultiplier: Vector2(3, 0),
          ),
        ]),
        baseVelocity: Vector2(20, 0),
      ),
    );
  }

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        resumeEngine();
        // resumeBackgroundMusic();
        break;
      case AppLifecycleState.paused:

      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
        pauseEngine();
        // pauseBackgroundMusic();
        break;
    }
    super.lifecycleStateChange(state);
  }
}
