import 'package:bitcoin_girl/models/score_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class ScoreOverlay extends StatefulWidget {
  static String id = 'ScoreOverlay';

  const ScoreOverlay({Key? key}) : super(key: key);

  @override
  State<ScoreOverlay> createState() => _ScoreOverlayState();
}

class _ScoreOverlayState extends State<ScoreOverlay> {
  @override
  Widget build(BuildContext context) {
    ScoreModel scoreModel = context.watch<ScoreModel>();

    return Row(
      children: List.generate(
        5,
        (index) {
          if (index < scoreModel.lives) {
            print(scoreModel.lives);
            return Icon(Icons.favorite, color: Colors.red);
          } else {
            return Icon(Icons.favorite_border, color: Colors.red);
          }
        },
      ),
    );
  }
}
