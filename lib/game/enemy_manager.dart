import 'dart:math';

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
      CharacterNameEnum.angryPigRun: SpriteSheetModel(
        imagePath: 'enemies/angry_pig/Run (36x30).png',
        characterPosition: Vector2(500, 200),
        amountsOfSpritesInSpriteSheet: 12,
        stepTimeBetweenEachSprite: 0.05,
        textureSizeOfEachSprite: Vector2(36, 30),
        spriteSizeOnCanvas: Vector2(35, 35),
        speed: Random().nextInt(3).toDouble() + 2,
        characterName: CharacterNameEnum.angryPigRun,
      ),
      CharacterNameEnum.angryPigWalk: SpriteSheetModel(
        imagePath: 'enemies/angry_pig/Walk (36x30).png',
        characterPosition: Vector2(500, 200),
        amountsOfSpritesInSpriteSheet: 16,
        stepTimeBetweenEachSprite: 0.05,
        textureSizeOfEachSprite: Vector2(36, 30),
        spriteSizeOnCanvas: Vector2(35, 35),
        speed: Random().nextInt(3).toDouble() + 2,
        characterName: CharacterNameEnum.angryPigWalk,
      ),
      CharacterNameEnum.batFly: SpriteSheetModel(
        imagePath: 'enemies/bat/Flying (46x30).png',
        characterPosition: Vector2(500, 200),
        amountsOfSpritesInSpriteSheet: 7,
        stepTimeBetweenEachSprite: 0.05,
        textureSizeOfEachSprite: Vector2(46, 30),
        spriteSizeOnCanvas: Vector2(35, 35),
        speed: Random().nextInt(3).toDouble() + 2,
        canFly: true,
        characterName: CharacterNameEnum.batFly,
      ),
      CharacterNameEnum.blueBird: SpriteSheetModel(
        imagePath: 'enemies/blue_bird/flying (32x32).png',
        characterPosition: Vector2(500, 200),
        amountsOfSpritesInSpriteSheet: 9,
        stepTimeBetweenEachSprite: 0.05,
        textureSizeOfEachSprite: Vector2(32, 32),
        spriteSizeOnCanvas: Vector2(35, 35),
        speed: Random().nextInt(3).toDouble() + 2,
        canFly: true,
        characterName: CharacterNameEnum.blueBird,
      ),
      CharacterNameEnum.bee: SpriteSheetModel(
        imagePath: 'enemies/bee/attack (36x34).png',
        characterPosition: Vector2(500, 200),
        amountsOfSpritesInSpriteSheet: 8,
        stepTimeBetweenEachSprite: 0.2,
        textureSizeOfEachSprite: Vector2(36, 34),
        spriteSizeOnCanvas: Vector2(25, 25),
        speed: Random().nextInt(2).toDouble() + 2,
        canFly: true,
        characterName: CharacterNameEnum.bee,
      ),
      CharacterNameEnum.bunny: SpriteSheetModel(
        imagePath: 'enemies/bunny/run(34x44).png',
        characterPosition: Vector2(500, 200),
        amountsOfSpritesInSpriteSheet: 12,
        stepTimeBetweenEachSprite: 0.06,
        textureSizeOfEachSprite: Vector2(34, 44),
        spriteSizeOnCanvas: Vector2(40, 40),
        speed: Random().nextInt(2).toDouble() + 2,
        characterName: CharacterNameEnum.bunny,
      ),
      CharacterNameEnum.chameleon: SpriteSheetModel(
        imagePath: 'enemies/chameleon/run (84x38).png',
        characterPosition: Vector2(500, 200),
        amountsOfSpritesInSpriteSheet: 8,
        stepTimeBetweenEachSprite: 0.05,
        textureSizeOfEachSprite: Vector2(84, 38),
        spriteSizeOnCanvas: Vector2(84, 38),
        speed: Random().nextInt(2).toDouble() + 2,
        characterName: CharacterNameEnum.chameleon,
      ),
      CharacterNameEnum.chicken: SpriteSheetModel(
        imagePath: 'enemies/chicken/run (32x34).png',
        characterPosition: Vector2(500, 200),
        amountsOfSpritesInSpriteSheet: 14,
        stepTimeBetweenEachSprite: 0.05,
        textureSizeOfEachSprite: Vector2(32, 34),
        spriteSizeOnCanvas: Vector2(32, 34),
        speed: Random().nextInt(2).toDouble() + 2,
        characterName: CharacterNameEnum.chicken,
      ),
      CharacterNameEnum.ghost: SpriteSheetModel(
        imagePath: 'enemies/ghost/appear (44x30).png',
        characterPosition: Vector2(500, 200),
        amountsOfSpritesInSpriteSheet: 4,
        stepTimeBetweenEachSprite: 0.4,
        textureSizeOfEachSprite: Vector2(44, 30),
        spriteSizeOnCanvas: Vector2(44, 30),
        speed: Random().nextInt(2).toDouble() + 2,
        characterName: CharacterNameEnum.ghost,
      ),
      CharacterNameEnum.mushroom: SpriteSheetModel(
        imagePath: 'enemies/mushroom/run (32x32).png',
        characterPosition: Vector2(500, 200),
        amountsOfSpritesInSpriteSheet: 16,
        stepTimeBetweenEachSprite: 0.05,
        textureSizeOfEachSprite: Vector2(32, 32),
        spriteSizeOnCanvas: Vector2(32, 32),
        speed: Random().nextInt(2).toDouble() + 2,
        characterName: CharacterNameEnum.mushroom,
      ),
      CharacterNameEnum.radish: SpriteSheetModel(
        imagePath: 'enemies/radish/run (30x38).png',
        characterPosition: Vector2(500, 200),
        amountsOfSpritesInSpriteSheet: 12,
        stepTimeBetweenEachSprite: 0.05,
        textureSizeOfEachSprite: Vector2(30, 38),
        spriteSizeOnCanvas: Vector2(30, 38),
        speed: Random().nextInt(2).toDouble() + 2,
        characterName: CharacterNameEnum.radish,
      ),
      CharacterNameEnum.rino: SpriteSheetModel(
        imagePath: 'enemies/rino/run (52x34).png',
        characterPosition: Vector2(500, 200),
        amountsOfSpritesInSpriteSheet: 6,
        stepTimeBetweenEachSprite: 0.2,
        textureSizeOfEachSprite: Vector2(52, 34),
        spriteSizeOnCanvas: Vector2(52, 34),
        speed: Random().nextInt(2).toDouble() + 2,
        characterName: CharacterNameEnum.rino,
      ),
      CharacterNameEnum.rocks: SpriteSheetModel(
        imagePath: 'enemies/rocks/run (22x18).png',
        characterPosition: Vector2(500, 200),
        amountsOfSpritesInSpriteSheet: 14,
        stepTimeBetweenEachSprite: 0.05,
        textureSizeOfEachSprite: Vector2(22, 18),
        spriteSizeOnCanvas: Vector2(22, 18),
        speed: Random().nextInt(2).toDouble() + 2,
        characterName: CharacterNameEnum.rocks,
      ),
      CharacterNameEnum.skull: SpriteSheetModel(
        imagePath: 'enemies/skull/idle 2 (52x54).png',
        characterPosition: Vector2(500, 200),
        amountsOfSpritesInSpriteSheet: 8,
        stepTimeBetweenEachSprite: 0.05,
        textureSizeOfEachSprite: Vector2(52, 54),
        spriteSizeOnCanvas: Vector2(52, 54),
        speed: Random().nextInt(2).toDouble() + 2,
        characterName: CharacterNameEnum.skull,
      ),
      CharacterNameEnum.slime: SpriteSheetModel(
        imagePath: 'enemies/slime/idle-run (44x30).png',
        characterPosition: Vector2(500, 200),
        amountsOfSpritesInSpriteSheet: 10,
        stepTimeBetweenEachSprite: 0.05,
        textureSizeOfEachSprite: Vector2(44, 30),
        spriteSizeOnCanvas: Vector2(44, 30),
        speed: Random().nextInt(2).toDouble() + 2,
        characterName: CharacterNameEnum.slime,
      ),
      CharacterNameEnum.snail: SpriteSheetModel(
        imagePath: 'enemies/snail/walk (38x24).png',
        characterPosition: Vector2(500, 200),
        amountsOfSpritesInSpriteSheet: 10,
        stepTimeBetweenEachSprite: 0.05,
        textureSizeOfEachSprite: Vector2(38, 24),
        spriteSizeOnCanvas: Vector2(38, 24),
        speed: Random().nextInt(2).toDouble() + 2,
        characterName: CharacterNameEnum.snail,
      ),
      CharacterNameEnum.trunk: SpriteSheetModel(
        imagePath: 'enemies/trunk/attack (64x32).png',
        characterPosition: Vector2(500, 200),
        amountsOfSpritesInSpriteSheet: 11,
        stepTimeBetweenEachSprite: 0.1,
        textureSizeOfEachSprite: Vector2(64, 32),
        spriteSizeOnCanvas: Vector2(64, 32),
        speed: Random().nextInt(2).toDouble() + 2,
        characterName: CharacterNameEnum.trunk,
      ),
      CharacterNameEnum.turtle: SpriteSheetModel(
        imagePath: 'enemies/turtle/spikes out (44x26).png',
        characterPosition: Vector2(500, 200),
        amountsOfSpritesInSpriteSheet: 8,
        stepTimeBetweenEachSprite: 0.05,
        textureSizeOfEachSprite: Vector2(44, 26),
        spriteSizeOnCanvas: Vector2(44, 26),
        speed: Random().nextInt(2).toDouble() + 2,
        characterName: CharacterNameEnum.turtle,
      ),
    };
  }

  Map<CharacterNameEnum, SpriteSheetModel> getCharactersBullet() {
    return {
      CharacterNameEnum.bee: SpriteSheetModel(
        imagePath: 'enemies/bee/bullet pieces.png',
        characterPosition: Vector2(100, 200),
        amountsOfSpritesInSpriteSheet: 2,
        stepTimeBetweenEachSprite: 0.05,
        textureSizeOfEachSprite: Vector2(16, 16),
        spriteSizeOnCanvas: Vector2(10, 10),
        characterName: CharacterNameEnum.bee,
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
