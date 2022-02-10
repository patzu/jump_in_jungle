import 'package:bitcoin_girl/widgets/score_overlay.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game/warrior_girl_game.dart';
import 'models/score_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScoreModel scoreModel = ScoreModel();
    var warriorGirlGame = WarriorGirlGame(scoreModel);

    return MultiProvider(
      providers: [
        ListenableProvider(create: (_) => scoreModel),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: GameWidget(
            game: warriorGirlGame,
            overlayBuilderMap: {
              ScoreOverlay.id: (_, WarriorGirlGame warriorGirlGame) =>
                  ScoreOverlay(warriorGirlGame),
            },
          ),
        ),
      ),
    );
  }
}
