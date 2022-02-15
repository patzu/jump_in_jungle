import 'package:bitcoin_girl/widgets/pause-overlay.dart';
import 'package:bitcoin_girl/widgets/score_overlay.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game/warrior_girl_game.dart';
import 'models/game_model.dart';
import 'models/score_overlay_model.dart';
import 'widgets/play_overlay.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScoreOverlayModel scoreModel = ScoreOverlayModel();
    var gameRef = WarriorGirlGame(scoreModel);

    return MultiProvider(
      providers: [
        ListenableProvider(create: (_) => scoreModel),
        ListenableProvider(create: (_) => GameModel(gameRef: gameRef)),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: GameWidget(
            game: gameRef,
            overlayBuilderMap: {
              ScoreOverlay.id: (_, __) => ScoreOverlay(),
              PlayOverlay.id: (_, __) => PlayOverlay(),
              PauseOverlay.id: (_, __) => PauseOverlay(),
            },
            initialActiveOverlays: [PlayOverlay.id],
          ),
        ),
      ),
    );
  }
}
