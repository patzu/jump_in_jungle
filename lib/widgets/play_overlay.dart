import 'package:bitcoin_girl/game/sound_manager_notifier.dart';
import 'package:bitcoin_girl/models/game_notifier.dart';
import 'package:bitcoin_girl/widgets/score_overlay_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayOverlay extends ConsumerWidget {
  static String id = 'PauseModal';

  const PlayOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final gameProviderRead = ref.read(gameProvider);


    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height / 3 * 2,
        color: Colors.white70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: Text('Play', style: TextStyle(fontSize: 25)),
              onPressed: () {
                gameProviderRead.gameRef?.startGame();
                gameProviderRead.gameRef?.overlays.remove(PlayOverlay.id);
              },
            ),
            SizedBox(height: 20),
            TextButton(
              child: Text(
                'Setting',
                style: TextStyle(fontSize: 25),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
