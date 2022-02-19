import 'dart:ui';

import 'package:bitcoin_girl/widgets/score_overlay_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/game_model.dart';

class GameOverOverlay extends StatelessWidget {
  static const String id = 'GameOverOverlay';

  const GameOverOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameRefModel = context.read<GameModel>();
    final scoreOverlayModel = context.read<ScoreOverlayModel>();
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 3 * 2,
          child: Card(
            color: Colors.amber,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Wrap(
                spacing: 8,
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text('GAME OVER', style: TextStyle(fontSize: 25)),
                  Text('Score: ${scoreOverlayModel.score}',
                      style: TextStyle(fontSize: 25)),
                  ElevatedButton(
                    onPressed: () {
                      gameRefModel.gameRef.overlays.remove(GameOverOverlay.id);
                      gameRefModel.resumeGameEngine();
                      gameRefModel.gameRef.reset();
                      gameRefModel.gameRef.startGame();
                    },
                    child: Text('Restart'),
                  ),
                  ElevatedButton(onPressed: () {}, child: Text('Exit')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
