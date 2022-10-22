import 'dart:io';
import 'dart:ui';

import 'package:bitcoin_girl/widgets/score_overlay_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../models/game_model.dart';

class PauseOverlay extends StatelessWidget {
  static const String id = 'PauseOverlay';

  const PauseOverlay({Key? key}) : super(key: key);

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
            color: Colors.amber[300],
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
                  Text('Your Score is: ${scoreOverlayModel.score}',
                      style: TextStyle(fontSize: 25)),
                  ElevatedButton(
                    onPressed: () {
                      gameRefModel.gameRef.overlays.remove(PauseOverlay.id);
                      GameModel.instance.resumeGameEngine();
                    },
                    child: Text('Resume'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      gameRefModel.resumeGameEngine();

                      gameRefModel.gameRef.overlays.remove(PauseOverlay.id);
                      gameRefModel.gameRef.reset();
                      gameRefModel.gameRef.startGame();
                    },
                    child: Text('Restart'),
                  ),
                  ElevatedButton(
                    onPressed: () => SystemNavigator.pop(),
                    child: Text('Exit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
