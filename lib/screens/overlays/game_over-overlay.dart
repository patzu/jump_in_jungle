import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jungler/notifiers/game_notifier.dart';
import 'package:jungler/notifiers/score_overlay_notifier.dart';

class GameOverOverlay extends ConsumerWidget {
  static const String id = 'GameOverOverlay';

  const GameOverOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameProviderRead = ref.read(gameProvider);
    final gameProviderNotifier = ref.read(gameProvider.notifier);
    final scoreOverlayProviderRead = ref.read(scoreOverlayProvider);
    return GestureDetector(
      onTap: (){

      },
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 3 * 2,
            child: Card(
              color: Colors.amber,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Wrap(
                  spacing: 8,
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text('GAME OVER', style: TextStyle(fontSize: 25)),
                    Text('Score: ${scoreOverlayProviderRead.score}',
                        style: TextStyle(fontSize: 25)),
                    ElevatedButton(
                      onPressed: () {
                        gameProviderRead.gameRef?.overlays
                            .remove(GameOverOverlay.id);
                        gameProviderNotifier.resumeGameEngine();
                        gameProviderRead.gameRef?.reset();
                        gameProviderRead.gameRef?.startGame();
                      },
                      child: Text('Restart'),
                    ),
                    ElevatedButton(
                        onPressed: () => SystemNavigator.pop(),
                        child: Text('Exit')),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
