import 'package:bitcoin_girl/game/warrior_girl_game.dart';
import 'package:bitcoin_girl/models/score_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class ScoreOverlay extends StatefulWidget {
  static String id = 'ScoreOverlay';
  final WarriorGirlGame warriorGirlGame;

  const ScoreOverlay(this.warriorGirlGame, {Key? key}) : super(key: key);

  @override
  State<ScoreOverlay> createState() => _ScoreOverlayState();
}

class _ScoreOverlayState extends State<ScoreOverlay> {
  bool isPaused = false;
  IconData _iconData = Icons.pause;

  @override
  Widget build(BuildContext context) {
    ScoreModel scoreModel = context.watch<ScoreModel>();

    return Padding(
      padding: const EdgeInsets.fromLTRB(100, 8, 100, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Score: ' + scoreModel.score.toString(),
                  style: TextStyle(fontSize: 20, color: Colors.white70),
                ),
                SizedBox(height: 5),
                Text(
                  'High: ' + scoreModel.highScore.toString(),
                  style: TextStyle(fontSize: 20, color: Colors.white70),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              if (isPaused) {
                widget.warriorGirlGame.resumeEngine();
                _iconData = Icons.pause;
                isPaused = false;
              } else {
                widget.warriorGirlGame.pauseEngine();
                _iconData = Icons.play_arrow;
                isPaused = true;
              }
              setState(() {});
            },
            child: Icon(
              _iconData,
              size: 30,
              color: Colors.white70,
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
