import 'dart:ui';

import 'package:bitcoin_girl/constants/constants.dart';
import 'package:bitcoin_girl/models/score_overlay_model.dart';
import 'package:bitcoin_girl/utils/texture_packer_loader.dart';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame_audio/flame_audio.dart';

import '../models/game_model.dart';
import 'enemy.dart';
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
  bool isIdle = true;
  bool isHit = false;

  final ScoreOverlayModel _scoreModel;
  late double deviceYAxisMinusGroundHeight;
  final Timer _hitTimer = Timer(1.2);

  GirlSprites(this._scoreModel) : super(priority: 1);

  @override
  Future<void>? onLoad() async {
    anchor = Anchor.bottomCenter;
    deviceYAxisMinusGroundHeight = gameRef.size.y - ground.y + 5;

    deadSpriteAnimation = await action(Action.dead);
    hitSpriteAnimation = await action(Action.hit);
    jumpSpriteAnimation = await action(Action.jump);
    runSpriteAnimation = await action(Action.run);

    addHitbox(HitboxCircle());
    position = Vector2(gameRef.size.x / 4, deviceYAxisMinusGroundHeight);

    return super.onLoad();
  }

  @override
  void onMount() {
    _hitTimer.onTick = () => {
          isHit = false,
        };

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
      if (isDead != true) {
        run();
      }

      deadSpriteAnimation.onComplete = () {
        GameModel.instance.pauseGameEngine();
      };

      // if (isDead == true) {
      // }
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

  Future<SpriteAnimation> action(Action action) async {
    final spriteSequence = await TexturePackerLoader.fromJSONAtlas(
        action.name + '.png', action.name + '.json');
    return SpriteAnimation.spriteList(
      spriteSequence,
      stepTime: action == Action.run
          ? 0.03
          : action == Action.dead
              ? 0.07
              : 0.05,
      loop: action.name == Action.dead.name ? false : true,
    );
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
      isIdle = false;
    }
  }

  run() {
    isDead = false;
    isJumping = false;
    isRunning = true;
    isIdle = false;
  }

  dead() {
    isDead = true;
    isJumping = false;
    isRunning = false;
    isIdle = false;
  }

  idle() {
    isDead = false;
    isJumping = false;
    isRunning = false;
    isIdle = true;
  }

  hit() {
    SoundManager.playHurtSound();
    _scoreModel.lives -= 1;
    if (_scoreModel.lives == 0) {
      dead();
    } else {
      _hitTimer.start();

      isDead = false;
      isJumping = false;
      isRunning = false;
      isIdle = false;
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
