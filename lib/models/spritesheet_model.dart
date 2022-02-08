import 'package:flame/components.dart';

class SpriteSheetModel {
  String imagePath;
  Vector2 characterPosition;
  int amountsOfSpritesInSpriteSheet;
  double stepTimeBetweenEachSprite;
  Vector2 textureSizeOfEachSprite;
  Vector2 spriteSizeOnCanvas;
  bool canFly;
  double speed;
  CharacterNameEnum characterName;

  SpriteSheetModel({
    required this.imagePath,
    required this.characterPosition,
    required this.amountsOfSpritesInSpriteSheet,
    required this.stepTimeBetweenEachSprite,
    required this.textureSizeOfEachSprite,
    required this.spriteSizeOnCanvas,
    required this.speed,
    this.canFly = false,
    this.characterName = CharacterNameEnum.batFly,
  });
}

enum CharacterNameEnum {
  // angryPigRun,
  // angryPigWalk,
  batFly,
  // blueBird,
  bee,
}
