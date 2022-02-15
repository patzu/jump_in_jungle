import 'package:bitcoin_girl/game/warrior_girl_game.dart';
import 'package:bitcoin_girl/models/score_overlay_model.dart';
import 'package:bitcoin_girl/widgets/play_overlay.dart';
import 'package:bitcoin_girl/widgets/score_overlay.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class GameLauncher extends StatelessWidget {
  GameLauncher({Key? key}) : super(key: key);

  final ScoreOverlayModel scoreModel = ScoreOverlayModel();

  @override
  Widget build(BuildContext context) {
    var warriorGirlGame = WarriorGirlGame(scoreModel);

    return GameWidget(
      game: warriorGirlGame,
      overlayBuilderMap: {
        ScoreOverlay.id: (_, __) => ScoreOverlay(),
        PlayOverlay.id: (_, __) => PlayOverlay()
      },
      initialActiveOverlays: [PlayOverlay.id],
    );
  }
}
