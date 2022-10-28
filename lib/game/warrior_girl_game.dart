import 'package:bitcoin_girl/game/player_data.dart';
import 'package:bitcoin_girl/game/sound_manager_notifier.dart';
import 'package:bitcoin_girl/models/game_notifier.dart';
import 'package:bitcoin_girl/widgets/score_overlay.dart';
import 'package:bitcoin_girl/widgets/score_overlay_notifier.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'enemy_data.dart';
import 'enemy_manager.dart';
import 'girl_sprite.dart';

class WarriorGirlGame extends FlameGame
    with TapDetector, HasCollisionDetection {
  WidgetRef ref;
  double score = 0.0;
  late GirlSprites girlSprites;
  late final ScoreOverlayNotifier scoreOverlayNotifier;
  late final GameNotifier gameNotifier;
  late final GameState readGameState;
  late final EnemyManager enemyManager;

  WarriorGirlGame(this.ref);

  @override
  void onMount() {
    ref.read(gameProvider.notifier).setGameRef(this);
  }

  @override
  Future<void>? onLoad() async {
    enemyManager = EnemyManager(ref);
    gameNotifier = ref.read(gameProvider.notifier);
    readGameState = ref.read(gameProvider);
    scoreOverlayNotifier = ref.read(scoreOverlayProvider.notifier);

    await images.loadAll(imageAssets);

    final parallax = await backgroundParallaxComponent();
    // final parallax = await plainParallaxComponent();
    add(parallax);

    final playerData = PlayerData();
    await playerData.init();

    girlSprites = GirlSprites(playerData, ref);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (readGameState.gameState == GameStateEnum.resume) {
      scoreOverlayNotifier.addScoreByOne();
    }

    super.update(dt);
  }

  void startGame() {
    Future.delayed(Duration(seconds: 1)).then((value) {
      ref.read(soundManagerProvider.notifier).playBackgroundMusic();
      gameNotifier.setPlayerState(PlayerStateEnum.alive);
      gameNotifier.setGameState(GameStateEnum.resume);

      overlays.add(ScoreOverlay.id);
      add(girlSprites..size = Vector2(40, 50));
      add(enemyManager);
      scoreOverlayNotifier.setScore(0);
      scoreOverlayNotifier.setLives(5);
    });
  }

  void reset() {
    overlays.remove(ScoreOverlay.id);
    girlSprites.removeFromParent();
    enemyManager.removeAllEnemies();
    enemyManager.removeFromParent();
  }

  @override
  void onTapDown(TapDownInfo info) {
    if (!girlSprites.isDead && gameNotifier.isResumed()) {
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
