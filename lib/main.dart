import 'package:bitcoin_girl/widgets/pause-overlay.dart';
import 'package:bitcoin_girl/widgets/score_overlay.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game/warrior_girl_game.dart';
import 'models/game_model.dart';
import 'widgets/game_over-overlay.dart';
import 'widgets/play_overlay.dart';
import 'widgets/score_overlay_model.dart';

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
    final gameRef = WarriorGirlGame(scoreModel);
    final gameModel = GameModel(gameRef: gameRef);

    print('main: ${gameRef.hashCode}');
    print('main: ${gameModel.gameRef.hashCode}');

    return MultiProvider(
      providers: [
        ListenableProvider(create: (_) => scoreModel),
        ListenableProvider(create: (_) => gameModel),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: GameWidget(
            game: gameRef,
            overlayBuilderMap: {
              ScoreOverlay.id: (_, __) => ScoreOverlay(),
              PlayOverlay.id: (_, __) => PlayOverlay(),
              PauseOverlay.id: (_, __) => PauseOverlay(),
              GameOverOverlay.id: (_, __) => GameOverOverlay(),
            },
            initialActiveOverlays: [PlayOverlay.id],
          ),
        ),
      ),
    );
  }
}
