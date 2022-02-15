import 'package:bitcoin_girl/widgets/pause-overlay.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../models/game_model.dart';
import '../models/score_overlay_model.dart';

class ScoreOverlay extends StatelessWidget {
  static const String id = 'ScoreOverlay';

  const ScoreOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScoreOverlayModel scoreModel = context.watch<ScoreOverlayModel>();
    final gameRefModel = context.read<GameModel>();

    IconData _iconData = Icons.pause;

    return Container(
      height: MediaQuery.of(context).size.height / 6,
      padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Score: ' + scoreModel.score.toString(),
                style: TextStyle(fontSize: 20, color: Colors.white70),
              ),
              Text(
                'High: ' + scoreModel.highScore.toString(),
                style: TextStyle(fontSize: 20, color: Colors.white70),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              gameRefModel.gameRef.overlays.add(PauseOverlay.id);
              _iconData = Icons.play_arrow;
              GameModel.instance.pauseGameEngine();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(_iconData, size: 30, color: Colors.white70),
            ),
          ),
          Row(
            children: List.generate(
              5,
              (index) {
                if (index < scoreModel.lives) {
                  return Icon(Icons.favorite, color: Colors.red);
                } else {
                  return Icon(Icons.favorite_border, color: Colors.red);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
