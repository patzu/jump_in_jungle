import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jungler/constants/enums.dart';
import 'package:jungler/game/components/bullet.dart';
import 'package:jungler/game/enemy_data.dart';
import 'package:jungler/notifiers/score_overlay_notifier.dart';
import 'package:jungler/notifiers/spritesheet_model.dart';

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

    _timer = Timer(Random().nextInt(2) + 1, repeat: true, autoStart: true,
        onTick: () {
      shoot();
    });

    int score = ref.read(scoreOverlayProvider.notifier).getScore();

    enemyData = enemyData.copyWith(
      speed: enemyData.speed +
          score / 2000 +
          Random().nextDouble() * 6 -
          Random().nextDouble() * 5,
    );

    return super.onLoad();
  }

  @override
  void onMount() {
    _timer.start();
  }

  @override
  void update(double dt) {
    position += Vector2(-enemyData.speed, 0);

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
    super.render(canvas);
  }
}
