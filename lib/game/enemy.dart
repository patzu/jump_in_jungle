import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jungler/widgets/score_overlay_notifier.dart';

import '../models/spritesheet_model.dart';
import 'bullet.dart';
import 'enemy_data.dart';

class Enemy extends SpriteAnimationComponent
    with HasGameRef, CollisionCallbacks {
  SpriteSheetModel enemyData;
  WidgetRef ref;

  Enemy(this.enemyData, this.ref);

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
    add(CircleHitbox());

    _timer = Timer(Random().nextInt(3) + 1, repeat: true, autoStart: true,
        onTick: () {
      shoot();
    });

    int score = ref.read(scoreOverlayProvider.notifier).getScore();

    enemyData.speed = enemyData.speed + score / 1000 + Random().nextInt(2).toDouble()+1;

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
          getCharactersBullet()[CharacterNameEnum.bee]!;
      final bullet = Bullet(this, bulletData, ref);
      bullet.size = bulletData.spriteSizeOnCanvas;
      bullet.position = Vector2(position.x, position.y + size.y / 2);
      gameRef.add(bullet);
    }
  }

  @override
  void render(Canvas canvas) {
    // renderHitboxes(canvas);

    super.render(canvas);
  }
}
