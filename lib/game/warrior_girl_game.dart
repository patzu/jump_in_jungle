import 'package:bitcoin_girl/models/game_model.dart';
import 'package:bitcoin_girl/models/score_overlay_model.dart';
import 'package:bitcoin_girl/widgets/pause-overlay.dart';
import 'package:bitcoin_girl/widgets/score_overlay.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import 'enemy_manager.dart';
import 'girl_sprite.dart';

class WarriorGirlGame extends FlameGame with TapDetector, HasCollidables {
  late GirlSprites girlSprites;
  double score = 0.0;
  late TextComponent scoreText;

  ScoreOverlayModel scoreModel;

  WarriorGirlGame(this.scoreModel);

  @override
  Future<void>? onLoad() async {
    // playBackgroundMusic();

    final parallax = await backgroundParallaxComponent();
    add(parallax);

    girlSprites = GirlSprites(scoreModel);

    scoreText = TextComponent(
      text: '$score',
      position: Vector2(300, 5),
    );

    // add(scoreText);

    overlays.add(ScoreOverlay.id);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (GameModel.instance.state == GameStateEnum.resume) {
      scoreModel.score += 1;
      scoreText.text = score.toInt().toString();
    }

    super.update(dt);
  }

  Future<void> startGame() async {
    GameModel.instance.state = GameStateEnum.resume;
    overlays.add(ScoreOverlay.id);
    await add(EnemyManager());
    await add(girlSprites..size = Vector2(40, 50));
  }

  void playBackgroundMusic() {
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play('bgmj.mp3');
  }

  @override
  void onTapDown(TapDownInfo info) {
    if (!girlSprites.isDead && !overlays.isActive(PauseOverlay.id)) {
      girlSprites.jump();
    }
  }

  Future<ParallaxComponent<FlameGame>> backgroundParallaxComponent() async {
    return ParallaxComponent(
      parallax: Parallax(
        await Future.wait([
          loadParallaxLayer(
            ParallaxImageData('parallax/plx-1.png'),
          ),
          loadParallaxLayer(
            ParallaxImageData('parallax/plx-2.png'),
            velocityMultiplier: Vector2(1.1, 0),
          ),
          loadParallaxLayer(
            ParallaxImageData('parallax/plx-3.png'),
            velocityMultiplier: Vector2(1.3, 0),
          ),
          loadParallaxLayer(
            ParallaxImageData('parallax/plx-4.png'),
            velocityMultiplier: Vector2(1.6, 0),
          ),
          loadParallaxLayer(
            ParallaxImageData('parallax/plx-5.png'),
            velocityMultiplier: Vector2(3, 0),
          ),
          loadParallaxLayer(
            ParallaxImageData('parallax/plx-6.png'),
            velocityMultiplier: Vector2(1.8, 0),
            alignment: Alignment.bottomCenter,
            fill: LayerFill.none,
          ),
        ]),
        baseVelocity: Vector2(20, 0),
      ),
    );
  }
}
