import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jungler/constants/constants.dart';
import 'package:jungler/game/components/enemy.dart';
import 'package:jungler/notifiers/sound_manager_notifier.dart';
import 'package:jungler/notifiers/spritesheet_model.dart';


class Bullet extends SpriteAnimationComponent
    with HasGameRef, CollisionCallbacks {
  SpriteSheetModel bulletData;
  Enemy bulletShooter;
  WidgetRef ref;

  Bullet(this.bulletShooter, this.bulletData, this.ref);

  @override
  Future<void>? onLoad() async {
    var spriteAnimationData = SpriteAnimationData.sequenced(
      amount: bulletData.amountsOfSpritesInSpriteSheet,
      stepTime: bulletData.stepTimeBetweenEachSprite,
      textureSize: bulletData.textureSizeOfEachSprite,
    );

    animation = await gameRef.loadSpriteAnimation(
        bulletData.imagePath, spriteAnimationData);

    anchor = Anchor.center;
    angle = -10;
    add(CircleHitbox());

    return super.onLoad();
  }

  @override
  void update(double dt) {
    position += Vector2(0, bulletData.speed);

    if (position.y > gameRef.size.y - ground.y) {
      removeFromParent();
    }
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    // renderHitboxes(canvas);

    super.render(canvas);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Enemy && other != bulletShooter && !other.enemyData.canFly) {
      ref
          .read<SoundManagerNotifier>(soundManagerProvider.notifier)
          .playHurtSound();
      other.removeFromParent();
      removeFromParent();
    }

    super.onCollision(intersectionPoints, other);
  }
}
