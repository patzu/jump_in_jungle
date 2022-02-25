import 'package:flame/components.dart';

import '../utils/texture_packer_loader.dart';
import 'girl_sprite.dart';

class PlayerData {
  late SpriteAnimation jumpSpriteAnimation;
  late SpriteAnimation deadSpriteAnimation;
  late SpriteAnimation runSpriteAnimation;
  late SpriteAnimation hitSpriteAnimation;

  Future<void>? init() async {
    deadSpriteAnimation = await action(Action.dead);
    hitSpriteAnimation = await action(Action.hit);
    jumpSpriteAnimation = await action(Action.jump);
    runSpriteAnimation = await action(Action.run);
  }

  Future<SpriteAnimation> action(Action action) async {
    final spriteSequence = await TexturePackerLoader.fromJSONAtlas(
        action.name + '.png', action.name + '.json');
    return SpriteAnimation.spriteList(
      spriteSequence,
      stepTime: action == Action.run
          ? 0.03
          : action == Action.dead
              ? 0.1
              : 0.05,
      loop: action.name == Action.dead.name ? false : true,
    );
  }
}
