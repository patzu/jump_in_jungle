import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jungler/constants/constants.dart';
import 'package:jungler/game/player_data.dart';
import 'package:jungler/notifiers/game_notifier.dart';
import 'package:jungler/notifiers/score_overlay_notifier.dart';
import 'package:jungler/notifiers/sound_manager_notifier.dart';
import 'package:jungler/screens/overlays/game_over-overlay.dart';

import 'enemy.dart';

class GirlSprites extends SpriteAnimationComponent
    with HasGameRef, CollisionCallbacks {
  late SpriteAnimation jumpSpriteAnimation;
  late SpriteAnimation deadSpriteAnimation;
  late SpriteAnimation runSpriteAnimation;
  late SpriteAnimation hitSpriteAnimation;

  Vector2 velocity = Vector2.zero();
  Vector2 gravity = Vector2(0, 500);
  bool isJumping = false;
  bool isRunning = false;
  bool isDead = false;
  bool isHit = false;

  final PlayerData playerData;

  double deviceYAxisMinusGroundHeight = 0;
  final Timer _hitTimer = Timer(1.2);
  WidgetRef ref;
  late final SoundManagerNotifier soundManagerNotifier;
  late final GameNotifier gameNotifier;
  late final ScoreOverlayNotifier scoreOverlayNotifier;

  GirlSprites(this.playerData, this.ref) : super(priority: 1) {
    scoreOverlayNotifier = ref.read(scoreOverlayProvider.notifier);

    soundManagerNotifier = ref.read(soundManagerProvider.notifier);
    gameNotifier = ref.read(gameProvider.notifier);
  }

  @override
  Future<void>? onLoad() {
    jumpSpriteAnimation = playerData.jumpSpriteAnimation;
    deadSpriteAnimation = playerData.deadSpriteAnimation;
    runSpriteAnimation = playerData.runSpriteAnimation;
    hitSpriteAnimation = playerData.hitSpriteAnimation;

    return super.onLoad();
  }

  @override
  void onMount() {
    anchor = Anchor.bottomCenter;
    deviceYAxisMinusGroundHeight = gameRef.size.y - ground.y + 5;
    add(CircleHitbox());
    position = Vector2(gameRef.size.x / 4, deviceYAxisMinusGroundHeight);

    _hitTimer.onTick = () => {
          isHit = false,
        };
    run();

    // deadSpriteAnimation.onComplete = () {
    //   GameModel.instance.pauseGameEngine();
    //   gameRef.overlays.add(GameOverOverlay.id);
    // };
    super.onMount();
  }

  @override
  void update(double dt) {
    if (isRunning) {
      runSpriteAnimation.update(dt);
    } else if (isJumping) {
      jumpSpriteAnimation.update(dt);
    } else if (isDead) {
      deadSpriteAnimation.update(dt);
    } else if (isHit) {
      hitSpriteAnimation.update(dt);
    }

    position += (velocity * dt - gravity * dt * dt / 2);
    velocity += gravity * dt;

    if (isPlayerBellowTheGround()) {
      resetPlayerPositionToTheGround();
    }

    if (isDead != true) {
      run();
    }
    if (gameNotifier.getPlayerState() == PlayerStateEnum.dead) {
      Future.delayed(Duration(seconds: 1)).then((value) {
        gameNotifier.pauseGameEngine();
        gameRef.overlays.add(GameOverOverlay.id);
      });
    }
    _hitTimer.update(dt);

    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    // render(canvas);

    if (isRunning) {
      runSpriteAnimation.getSprite().render(canvas, size: size);
    } else if (isJumping) {
      jumpSpriteAnimation.getSprite().render(canvas, size: size);
    } else if (isDead) {
      deadSpriteAnimation.getSprite().render(canvas, size: size);
    } else if (isHit) {
      hitSpriteAnimation.getSprite().render(canvas, size: size);
    }

    super.render(canvas);
  }

  void resetPlayerPositionToTheGround() {
    position = Vector2(gameRef.size.x / 4, deviceYAxisMinusGroundHeight);
  }

  bool isPlayerBellowTheGround() {
    return (position.y >= deviceYAxisMinusGroundHeight);
  }

  jump() {
    if (isPlayerBellowTheGround()) {
      soundManagerNotifier.playJumpAudio();

      velocity = Vector2(
        0,
        -deviceYAxisMinusGroundHeight,
      );

      isDead = false;
      isJumping = true;
      isRunning = false;
    }
  }

  run() {
    isDead = false;
    isJumping = false;
    isRunning = true;
  }

  dead() {
    isDead = true;
    isJumping = false;
    isRunning = false;
    gameNotifier.setPlayerState(PlayerStateEnum.dead);
  }

  idle() {
    isDead = false;
    isJumping = false;
    isRunning = false;
  }

  hit() {
    soundManagerNotifier.playHurtSound();
    scoreOverlayNotifier.SubtractLivesByOne();
    if (scoreOverlayNotifier.getLives() == 0) {
      dead();
    } else {
      _hitTimer.start();

      isDead = false;
      isJumping = false;
      isRunning = false;
      isHit = true;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Enemy && !isHit && !isDead) {
      hit();
    }
    super.onCollision(intersectionPoints, other);
  }
}

enum Action {
  run,
  jump,
  dead,
  idle,
  hit,
}
