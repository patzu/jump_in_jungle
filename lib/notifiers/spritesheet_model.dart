import 'package:flame/components.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jungler/constants/enums.dart';

part 'spritesheet_model.freezed.dart';

@freezed
class SpriteSheetModel with _$SpriteSheetModel {
  const factory SpriteSheetModel({
    required String imagePath,
    required Vector2 characterPosition,
    required int amountsOfSpritesInSpriteSheet,
    required double stepTimeBetweenEachSprite,
    required Vector2 textureSizeOfEachSprite,
    required Vector2 spriteSizeOnCanvas,
    required double speed,
    required CharacterNameEnum characterName,
    @Default(false) bool canFly,
  }) = _SpriteSheetModel;
}


