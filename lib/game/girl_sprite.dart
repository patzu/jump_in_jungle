import 'dart:ui';

import 'package:bitcoin_girl/constants/constants.dart';
import 'package:bitcoin_girl/widgets/score_overlay_model.dart';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame_audio/flame_audio.dart';

import '../models/game_model.dart';
import '../widgets/game_over-overlay.dart';
import 'enemy.dart';
import 'player_data.dart';
import 'sound_manager.dart';

class GirlSprites extends SpriteAnimationComponent
    with HasGameRef, HasHitboxes, Collidable {
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

  final ScoreOverlayModel scoreModel;
  final PlayerData playerData;

  double deviceYAxisMinusGroundHeight = 0;
  final Timer _hitTimer = Timer(1.2);

  GirlSprites(this.scoreModel, this.playerData) : super(priority: 1);

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
    addHitbox(HitboxCircle());
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
    if (GameModel.instance.playerState == PlayerStateEnum.dead) {
      Future.delayed(Duration(seconds: 1)).then((value) {
        GameModel.instance.pauseGameEngine();
        gameRef.overlays.add(GameOverOverlay.id);
      });
    }
    _hitTimer.update(dt);

    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    renderHitboxes(canvas);

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
      FlameAudio.audioCache.play('jump14.wav');

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
    GameModel.instance.playerState = PlayerStateEnum.dead;
  }

  idle() {
    isDead = false;
    isJumping = false;
    isRunning = false;
  }

  hit() {
    SoundManager.playHurtSound();
    scoreModel.lives -= 1;
    if (scoreModel.lives == 0) {
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
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
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
