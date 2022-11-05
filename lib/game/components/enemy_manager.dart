import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jungler/constants/constants.dart';
import 'package:jungler/constants/enums.dart';
import 'package:jungler/game/enemy_data.dart';
import 'package:jungler/game/jungler_game.dart';
import 'package:jungler/notifiers/spritesheet_model.dart';

import 'enemy.dart';

class EnemyManager extends Component with HasGameRef<JunglerGame> {
  late Timer _timer;
  late Enemy enemy;
  final Random _random = Random();
  WidgetRef ref;
  bool isSplashScreen = false;

  EnemyManager(this.ref, this.isSplashScreen);

  @override
  Future<void>? onLoad() {
    _timer = Timer(
      isSplashScreen ? 0.05 : Random().nextInt(2) + 1,
      repeat: true,
      onTick: () => {
        spawnEnemy(),
      },
    );

    return super.onLoad();
  }

  spawnEnemy() {
    SpriteSheetModel enemyData = getRandomEnemy()!;
    enemy = Enemy(enemyData, ref);
    enemy.position = Vector2(gameRef.size.x,
        gameRef.size.y - ground.y - enemyData.spriteSizeOnCanvas.y / 2 + 10);

    if (enemy.enemyData.canFly) {
      enemy.position.y -= _random.nextInt(220) + 5;
    }

    enemy.size = enemyData.spriteSizeOnCanvas;

    add(enemy);
  }

  @override
  void onMount() {
    _timer.start();
  }

  @override
  void update(double dt) {
    _timer.update(dt);

    super.update(dt);
  }

  SpriteSheetModel? getRandomEnemy() {
    int enemyTypeIndex = Random().nextInt(CharacterNameEnum.values.length);
    CharacterNameEnum randomEnemyType =
        CharacterNameEnum.values.elementAt(enemyTypeIndex);
    return getEnemiesMap()[randomEnemyType];
  }

  void removeAllEnemies() {
    final enemies = children.whereType<Enemy>();
    for (var enemy in enemies) {
      enemy.removeFromParent();
      // for (var element in enemy.animation!.frames) {
      //   element.sprite.image.dispose();
      // }
    }
  }
}
