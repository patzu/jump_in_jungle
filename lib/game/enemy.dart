import 'dart:math';
import 'dart:ui';

import 'package:bitcoin_girl/models/spritesheet_model.dart';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

import 'bullet.dart';
import 'enemy_manager.dart';

class Enemy extends SpriteAnimationComponent
    with HasGameRef, HasHitboxes, Collidable {
  SpriteSheetModel enemyData;

  Enemy(this.enemyData);

  late Timer _timer;

  @override
  Future<void>? onLoad() async {
    var spriteAnimationData = SpriteAnimationData.sequenced(
      amount: enemyData.amountsOfSpritesInSpriteSheet,
      stepTime: enemyData.stepTimeBetweenEachSprite,
      textureSize: enemyData.textureSizeOfEachSprite,
    );

    animation = await gameRef.loadSpriteAnimation(
        enemyData.imagePath, spriteAnimationData);

    anchor = Anchor.center;
    addHitbox(HitboxCircle());

    _timer = Timer(Random().nextInt(7) + 4, repeat: true, autoStart: true,
        onTick: () {
      shoot();
    });

    return super.onLoad();
  }

  @override
  void onMount() {
    _timer.start();
  }

  @override
  void update(double dt) {
    position += Vector2(-enemyData.speed, 0);

    // shoot();

    _timer.update(dt);

    if (position.x < -20) {
      removeFromParent();
    }
    super.update(dt);
  }

  void shoot() {
    if (enemyData.characterName == CharacterNameEnum.bee) {
      SpriteSheetModel bulletData =
          EnemyManager().getCharactersBullet()[CharacterNameEnum.bee]!;
      final bullet = Bullet(this, bulletData);
      bullet.size = bulletData.spriteSizeOnCanvas;
      bullet.position = Vector2(position.x, position.y + size.y / 2);
      gameRef.add(bullet);
    }
  }

  @override
  void render(Canvas canvas) {
    renderHitboxes(canvas);

    super.render(canvas);
  }
}
