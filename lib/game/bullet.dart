import 'dart:ui';

import 'package:bitcoin_girl/constants/constants.dart';
import 'package:bitcoin_girl/game/enemy.dart';
import 'package:bitcoin_girl/game/sound_manager.dart';
import 'package:bitcoin_girl/models/spritesheet_model.dart';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

class Bullet extends SpriteAnimationComponent
    with HasGameRef, HasHitboxes, Collidable {
  SpriteSheetModel bulletData;

  Enemy bulletShooter;

  Bullet(this.bulletShooter, this.bulletData);

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
    addHitbox(HitboxCircle());

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
    renderHitboxes(canvas);

    super.render(canvas);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is Enemy && other != bulletShooter) {
      SoundManager.playHurtSound();
      other.removeFromParent();
      removeFromParent();
    }

    super.onCollision(intersectionPoints, other);
  }
}
