import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jungler/notifiers/game_notifier.dart';
import 'package:jungler/notifiers/score_overlay_notifier.dart';
import 'package:jungler/screens/overlays/pause-overlay.dart';
import 'package:jungler/screens/overlays/setting_overlay.dart';

class ScoreOverlay extends ConsumerWidget {
  static const String id = 'ScoreOverlay';

  ScoreOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScoreOverlayState watchScoreOverlayState = ref.watch(scoreOverlayProvider);
    GameState readGameState = ref.read(gameProvider);
    GameNotifier gameNotifier = ref.read(gameProvider.notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2 - 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.settings),
                color: Colors.grey,
                iconSize: 20,
                onPressed: () {
                  readGameState.gameRef?.overlays.add(SettingOverlay.id);
                  gameNotifier.pauseGameEngine();
                },
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Score: ${watchScoreOverlayState.score}',
                    style: TextStyle(fontSize: 20, color: Colors.white70),
                  ),
                  Text(
                    'HighScore: ${watchScoreOverlayState.highScore}',
                    style: TextStyle(fontSize: 20, color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            readGameState.gameRef?.overlays.add(PauseOverlay.id);
            gameNotifier.pauseGameEngine();
          },
          icon: Icon(Icons.pause, size: 30, color: Colors.white70),
        ),
        Spacer(),
        Row(
          children: List.generate(
            5,
            (index) {
              if (index < watchScoreOverlayState.lives) {
                return Icon(Icons.favorite, color: Colors.red);
              } else {
                return Icon(Icons.favorite_border, color: Colors.red);
              }
            },
          ),
        ),
        Spacer(),
      ],
    );
  }
}
