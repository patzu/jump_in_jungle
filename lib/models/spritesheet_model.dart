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
    required this.characterName,
    required this.speed,
    this.canFly = false,
  });
}

enum CharacterNameEnum {
  angryPigRun,
  angryPigWalk,
  batFly,
  blueBird,
  bee,
  bunny,
  chameleon,
  chicken,
  // duck,
  // fatBird,
  ghost,
  mushroom,
  // plant,
  radish,
  rino,
  rocks,
  skull,
  slime,
  snail,
  trunk,
  turtle,
}
