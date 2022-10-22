import 'dart:math';

import 'package:flame/components.dart';

import '../constants/constants.dart';
import '../models/spritesheet_model.dart';
import 'enemy.dart';
import 'enemy_data.dart';
import 'warrior_girl_game.dart';

class EnemyManager extends Component with HasGameRef<WarriorGirlGame> {
  late Timer _timer;
  late Enemy enemy;
  final Random _random = Random();

  @override
  Future<void>? onLoad() {
    _timer = Timer(
      Random().nextInt(2) + 2,
      repeat: true,
      onTick: () => {
        spawnEnemy(),
      },
    );

    return super.onLoad();
  }

  spawnEnemy() {
    SpriteSheetModel enemyData = getRandomEnemy()!;
    enemy = Enemy(enemyData);
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
