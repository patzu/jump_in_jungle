import 'dart:ui';

import 'package:bitcoin_girl/constants/constants.dart';
import 'package:bitcoin_girl/models/score_model.dart';
import 'package:bitcoin_girl/utils/texture_packer_loader.dart';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame_audio/flame_audio.dart';

import 'enemy.dart';
import 'sound_manager.dart';
import 'warrior_girl_game.dart';

class GirlSprites extends SpriteAnimationComponent
    with HasGameRef, HasHitboxes, Collidable {
  late SpriteAnimation walkSpriteAnimation;
  late SpriteAnimation jumpSpriteAnimation;
  late SpriteAnimation deadSpriteAnimation;
  late SpriteAnimation runSpriteAnimation;
  late SpriteAnimation idleSpriteAnimation;
  late SpriteAnimation hitSpriteAnimation;

  Vector2 velocity = Vector2.zero();
  Vector2 gravity = Vector2(0, 500);
  bool isWalking = false;
  bool isJumping = false;
  bool isRunning = false;
  bool isDead = false;
  bool isIdle = true;
  bool isHit = false;

  WarriorGirlGame game;
  final ScoreModel _scoreModel;
  late double deviceYAxisMinusGroundHeight;
  final Timer _hitTimer = Timer(1.2);

  GirlSprites(this.game, this._scoreModel) : super(priority: 1);

  @override
  Future<void>? onLoad() async {
    anchor = Anchor.bottomCenter;
    deviceYAxisMinusGroundHeight = gameRef.size.y - ground.y + 5;

    walkSpriteAnimation = await action(Action.walk);
    jumpSpriteAnimation = await action(Action.jump);
    deadSpriteAnimation = await action(Action.dead);
    runSpriteAnimation = await action(Action.run);
    idleSpriteAnimation = await action(Action.idle);
    hitSpriteAnimation = await action(Action.hit);

    addHitbox(HitboxCircle());
    position = Vector2(gameRef.size.x / 4, deviceYAxisMinusGroundHeight);

    return super.onLoad();
  }

  @override
  void onMount() {
    _hitTimer.onTick = () => {
          isHit = false,
          run(),
        };

    super.onMount();
  }

  @override
  void update(double dt) {
    if (isWalking) {
      walkSpriteAnimation.update(dt);
    } else if (isRunning) {
      runSpriteAnimation.update(dt);
    } else if (isJumping) {
      jumpSpriteAnimation.update(dt);
    } else if (isDead) {
      deadSpriteAnimation.update(dt);
    } else if (isIdle) {
      idleSpriteAnimation.update(dt);
    } else if (isHit) {
      hitSpriteAnimation.update(dt);
    }

    position += (velocity * dt);
    velocity += gravity * dt;

    if (isPlayerBellowTheGround()) {
      resetPlayerPositionToTheGround();
    }

    _hitTimer.update(dt);

    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    renderHitboxes(canvas);

    if (isWalking) {
      walkSpriteAnimation.getSprite().render(canvas, size: size);
    } else if (isRunning) {
      runSpriteAnimation.getSprite().render(canvas, size: size);
    } else if (isJumping) {
      jumpSpriteAnimation.getSprite().render(canvas, size: size);
    } else if (isDead) {
      deadSpriteAnimation.getSprite().render(canvas, size: size);
    } else if (isIdle) {
      idleSpriteAnimation.getSprite().render(canvas, size: size);
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
    );
  }

  void resetPlayerPositionToTheGround() {
    position = Vector2(gameRef.size.x / 4, deviceYAxisMinusGroundHeight);
  }

  bool isPlayerOnTheGround() {
    return (position.y == deviceYAxisMinusGroundHeight);
  }

  bool isPlayerBellowTheGround() {
    return (position.y > deviceYAxisMinusGroundHeight);
  }

  jump() {
    if (isPlayerOnTheGround()) {
      FlameAudio.audioCache.play('jump14.wav');

      velocity = Vector2(
        0,
        -deviceYAxisMinusGroundHeight,
      );

      isDead = false;
      isJumping = true;
      isRunning = false;
      isWalking = false;
      isIdle = false;
    }
  }

  run() {
    isDead = false;
    isJumping = false;
    isRunning = true;
    isWalking = false;
    isIdle = false;
  }

  walk() {
    isDead = false;
    isJumping = false;
    isRunning = false;
    isWalking = true;
    isIdle = false;
  }

  dead() {
    isDead = true;
    isJumping = false;
    isRunning = false;
    isWalking = false;
    isIdle = false;
  }

  idle() {
    isDead = false;
    isJumping = false;
    isRunning = false;
    isWalking = false;
    isIdle = true;
  }

  hit() {
    isDead = false;
    isJumping = false;
    isRunning = false;
    isWalking = false;
    isIdle = false;
    isHit = true;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is Enemy && !isHit) {
      _scoreModel.lives -= 1;
      _hitTimer.start();
      hit();
      SoundManager.playHurtSound();
    }
    super.onCollision(intersectionPoints, other);
  }
}

enum Action {
  run,
  walk,
  jump,
  dead,
  idle,
  hit,
}
