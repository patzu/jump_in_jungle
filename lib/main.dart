import 'package:bitcoin_girl/game/warrior_girl_game.dart';
import 'package:bitcoin_girl/widgets/game_over-overlay.dart';
import 'package:bitcoin_girl/widgets/pause-overlay.dart';
import 'package:bitcoin_girl/widgets/play_overlay.dart';
import 'package:bitcoin_girl/widgets/score_overlay.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final warriorGirlGame = WarriorGirlGame(ref);

    return Scaffold(
      body: GameWidget(
        game: warriorGirlGame,
        overlayBuilderMap: {
          ScoreOverlay.id: (_, __) => ScoreOverlay(),
          PlayOverlay.id: (_, __) => PlayOverlay(),
          PauseOverlay.id: (_, __) => PauseOverlay(),
          GameOverOverlay.id: (_, __) => GameOverOverlay(),
        },
        initialActiveOverlays: [PlayOverlay.id],
      ),
    );
  }
}
