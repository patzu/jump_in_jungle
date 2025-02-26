import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jungler/screens/overlays/game_over-overlay.dart';
import 'package:jungler/screens/overlays/play_overlay.dart';
import 'package:jungler/screens/overlays/score_overlay.dart';
import 'package:jungler/screens/overlays/setting_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'game/jungler_game.dart';
import 'screens/overlays/pause-overlay.dart';

final sharedPreferencesProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: MyApp(),
    ),
  );
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
    final junglerGame = JunglerGame(ref);

    return Scaffold(
      body: GameWidget(
        game: junglerGame,
        overlayBuilderMap: {
          ScoreOverlay.id: (_, __) => ScoreOverlay(),
          PlayOverlay.id: (_, __) => PlayOverlay(),
          PauseOverlay.id: (_, __) => PauseOverlay(),
          GameOverOverlay.id: (_, __) => GameOverOverlay(),
          SettingOverlay.id: (_, __) => SettingOverlay(),
        },
        initialActiveOverlays: [PlayOverlay.id],
      ),
    );
  }
}
