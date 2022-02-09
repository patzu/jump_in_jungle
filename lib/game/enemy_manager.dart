import 'dart:math';

import 'package:bitcoin_girl/game/bullet.dart';
import 'package:flame/components.dart';

import '../constants/constants.dart';
import '../models/spritesheet_model.dart';
import 'enemy.dart';
import 'warrior_girl_game.dart';

class EnemyManager extends Component with HasGameRef<WarriorGirlGame> {
  late Timer _timer;
  late Enemy enemy;
  final Random _random = Random();

  @override
  Future<void>? onLoad() {
    _timer = Timer(
      Random().nextInt(3) + 4,
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

  Map<CharacterNameEnum, SpriteSheetModel> getEnemiesMap() {
    return {
      // CharacterNameEnum.angryPigRun: SpriteSheetModel(
      //   imagePath: 'enemies/angry_pig/Run (36x30).png',
      //   characterPosition: Vector2(500, 200),
      //   amountsOfSpritesInSpriteSheet: 12,
      //   stepTimeBetweenEachSprite: 0.05,
      //   textureSizeOfEachSprite: Vector2(36, 30),
      //   spriteSizeOnCanvas: Vector2(35, 35),
      //   speed: Random().nextInt(3).toDouble() + 2,
      // ),
      // CharacterNameEnum.angryPigWalk: SpriteSheetModel(
      //   imagePath: 'enemies/angry_pig/Walk (36x30).png',
      //   characterPosition: Vector2(500, 200),
      //   amountsOfSpritesInSpriteSheet: 16,
      //   stepTimeBetweenEachSprite: 0.05,
      //   textureSizeOfEachSprite: Vector2(36, 30),
      //   spriteSizeOnCanvas: Vector2(35, 35),
      //   speed: Random().nextInt(3).toDouble() + 2,
      // ),
      CharacterNameEnum.batFly: SpriteSheetModel(
        imagePath: 'enemies/bat/Flying (46x30).png',
        characterPosition: Vector2(500, 200),
        amountsOfSpritesInSpriteSheet: 7,
        stepTimeBetweenEachSprite: 0.05,
        textureSizeOfEachSprite: Vector2(46, 30),
        spriteSizeOnCanvas: Vector2(35, 35),
        speed: Random().nextInt(3).toDouble() + 2,
        canFly: true,
      ),
      // CharacterNameEnum.blueBird: SpriteSheetModel(
      //   imagePath: 'enemies/BlueBird/Flying (32x32).png',
      //   characterPosition: Vector2(500, 200),
      //   amountsOfSpritesInSpriteSheet: 9,
      //   stepTimeBetweenEachSprite: 0.05,
      //   textureSizeOfEachSprite: Vector2(32, 32),
      //   spriteSizeOnCanvas: Vector2(35, 35),
      //   speed: Random().nextInt(3).toDouble() + 2,
      //   canFly: true,
      // ),
      CharacterNameEnum.bee: SpriteSheetModel(
        imagePath: 'enemies/bee/Attack (36x34).png',
        characterPosition: Vector2(500, 200),
        amountsOfSpritesInSpriteSheet: 8,
        stepTimeBetweenEachSprite: 0.09,
        textureSizeOfEachSprite: Vector2(36, 34),
        spriteSizeOnCanvas: Vector2(25, 25),
        speed: Random().nextInt(2).toDouble() + 1,
        canFly: true,
        characterName: CharacterNameEnum.bee,
      ),
      CharacterNameEnum.bunny: SpriteSheetModel(
        imagePath: 'enemies/Bunny/Run (34x44).png',
        characterPosition: Vector2(500, 200),
        amountsOfSpritesInSpriteSheet: 12,
        stepTimeBetweenEachSprite: 0.06,
        textureSizeOfEachSprite: Vector2(34, 44),
        spriteSizeOnCanvas: Vector2(40, 40),
        speed: Random().nextInt(2).toDouble() + 2,
      ),
    };
  }

  Map<CharacterNameEnum, SpriteSheetModel> getCharactersBullet() {
    return {
      CharacterNameEnum.bee: SpriteSheetModel(
        imagePath: 'enemies/bee/Bullet Pieces.png',
        characterPosition: Vector2(100, 200),
        amountsOfSpritesInSpriteSheet: 2,
        stepTimeBetweenEachSprite: 0.05,
        textureSizeOfEachSprite: Vector2(16, 16),
        spriteSizeOnCanvas: Vector2(10, 10),
        speed: 0.5,
        canFly: true,
      ),
    };
  }

  SpriteSheetModel? getRandomEnemy() {
    int enemyTypeIndex = Random().nextInt(CharacterNameEnum.values.length);
    CharacterNameEnum randomEnemyType =
        CharacterNameEnum.values.elementAt(enemyTypeIndex);
    return getEnemiesMap()[randomEnemyType];
  }
}

enum CharacterBulletsEnum {
  beeBullet,
}
