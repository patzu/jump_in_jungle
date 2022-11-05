import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jungler/game/components/enemy_manager.dart';
import 'package:jungler/game/components/girl_sprite.dart';
import 'package:jungler/game/enemy_data.dart';
import 'package:jungler/game/player_data.dart';
import 'package:jungler/main.dart';
import 'package:jungler/notifiers/game_notifier.dart';
import 'package:jungler/notifiers/score_overlay_notifier.dart';
import 'package:jungler/notifiers/sound_manager_notifier.dart';
import 'package:jungler/screens/overlays/score_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JunglerGame extends FlameGame with TapDetector, HasCollisionDetection {
  WidgetRef ref;
  double score = 0.0;
  late GirlSprites girlSprites;
  late final ScoreOverlayNotifier scoreOverlayNotifier;
  late final GameNotifier gameNotifier;
  late final EnemyManager enemyManager;
  late final SharedPreferences shared;
  late final ParallaxComponent parallaxComponent;
  late final EnemyManager splashEnemyManager;

  JunglerGame(this.ref);

  @override
  void onMount() {
    gameNotifier.setGameRef(this);
  }

  @override
  Future<void>? onLoad() async {
    enemyManager = EnemyManager(ref, false);
    gameNotifier = ref.read(gameProvider.notifier);
    scoreOverlayNotifier = ref.read(scoreOverlayProvider.notifier);

    await images.loadAll(imageAssets);

    parallaxComponent = await backgroundParallaxComponent();
    // final parallaxComponent = await plainParallaxComponent();
    add(parallaxComponent);

    final playerData = PlayerData();
    await playerData.init();

    girlSprites = GirlSprites(playerData, ref);

    shared = ref.read(sharedPreferencesProvider);
    if (shared.containsKey('highScore')) {
      scoreOverlayNotifier.setHighScore(shared.getInt('highScore')!);
    } else {
      shared.setInt('highScore', 0);
    }
    splashEnemyManager = EnemyManager(ref, true);
    add(splashEnemyManager);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (gameNotifier.getGameState() == GameStateEnum.resume) {
      scoreOverlayNotifier.addScoreByOne();
      if (scoreOverlayNotifier.getScore() >= shared.getInt('highScore')!) {
        scoreOverlayNotifier.setHighScore(scoreOverlayNotifier.getScore());
        shared.setInt('highScore', scoreOverlayNotifier.getScore());
      }
    }

    int score = scoreOverlayNotifier.getScore();
    if (score % 20 == 0) {
      var layers = parallaxComponent.parallax!.layers;
      for (var element in layers) {
        element.velocityMultiplier =
            element.velocityMultiplier + Vector2(score / 200000, 0);
      }
    }
    super.update(dt);
  }

  void startGame() {
    Future.delayed(Duration(seconds: 1)).then((value) {
      splashEnemyManager.removeAllEnemies();
      splashEnemyManager.removeFromParent();
      ref.read(soundManagerProvider.notifier).playBackgroundMusic();
      gameNotifier.setPlayerState(PlayerStateEnum.alive);
      gameNotifier.setGameState(GameStateEnum.resume);

      overlays.add(ScoreOverlay.id);
      add(girlSprites..size = Vector2(40, 50));
      add(enemyManager);
      scoreOverlayNotifier.setScore(0);
      scoreOverlayNotifier.setHighScore(
          ref.read(sharedPreferencesProvider).getInt('highScore')!);
      scoreOverlayNotifier.setLives(5);

      var layers = parallaxComponent.parallax!.layers;
      layers[0].velocityMultiplier = Vector2(0, 0);
      layers[1].velocityMultiplier = Vector2(1.1, 0);
      layers[2].velocityMultiplier = Vector2(1.3, 0);
      layers[3].velocityMultiplier = Vector2(1.6, 0);
      layers[4].velocityMultiplier = Vector2(3, 0);
      layers[5].velocityMultiplier = Vector2(1.8, 0);
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
