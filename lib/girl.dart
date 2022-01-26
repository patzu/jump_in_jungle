import 'dart:ui';

import 'package:dinogame/warrior_girl_game.dart';
import 'package:flame/components.dart';
import 'utils/texture_packer_loader.dart';

class GirlSprites extends SpriteAnimationComponent with HasGameRef {
  late SpriteAnimation walkSpriteAnimation;
  late SpriteAnimation jumpSpriteAnimation;
  late SpriteAnimation deadSpriteAnimation;
  late SpriteAnimation runSpriteAnimation;
  late SpriteAnimation idleSpriteAnimation;

  Vector2 velocity = Vector2.zero();
  Vector2 gravity = Vector2(0, 500);
  bool isWalking = false;
  bool isJumping = false;
  bool isRunning = false;
  bool isDead = false;
  bool isIdle = true;
  WarriorGirlGame game;

  GirlSprites(this.game);

  @override
  Future<void>? onLoad() async {
    walkSpriteAnimation = await action(Action.walk);
    jumpSpriteAnimation = await action(Action.jump);
    deadSpriteAnimation = await action(Action.dead);
    runSpriteAnimation = await action(Action.run);
    idleSpriteAnimation = await action(Action.idle);

    position = Vector2(gameRef.size.x / 4, gameRef.size.y - size.y / 2 - 15);

    anchor = Anchor.center;

    return super.onLoad();
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
    }

    position += (velocity * dt);
    velocity += gravity * dt;

    if (isOnGround()) {
      position = Vector2(gameRef.size.x / 4, gameRef.size.y - size.y / 2 - 15);
      if (!game.firstTap) {
        run();
      }
    }

    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    if (isWalking) {
      walkSpriteAnimation.getSprite().render(canvas, size: Vector2.all(100));
    } else if (isRunning) {
      runSpriteAnimation.getSprite().render(canvas, size: Vector2.all(100));
    } else if (isJumping) {
      jumpSpriteAnimation.getSprite().render(canvas, size: Vector2.all(100));
    } else if (isDead) {
      deadSpriteAnimation.getSprite().render(canvas, size: Vector2.all(100));
    } else if (isIdle) {
      idleSpriteAnimation.getSprite().render(canvas, size: Vector2.all(100));
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

  bool isOnGround() {
    if (position.y >= gameRef.size.y - size.y / 2 - 15) {
      return true;
    }
    return false;
  }

  jump() {
    if (isOnGround()) {
      velocity = Vector2(0, -gameRef.size.y - size.y - 15);

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
}

enum Action {
  run,
  walk,
  jump,
  dead,
  idle,
}
