import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jungler/notifiers/game_notifier.dart';
import 'package:jungler/notifiers/score_overlay_notifier.dart';

class PauseOverlay extends ConsumerWidget {
  static const String id = 'PauseOverlay';

  const PauseOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scoreOverlayProviderWatch = ref.watch(scoreOverlayProvider);
    final gameProviderRead = ref.read(gameProvider);
    final gameNotifier = ref.read(gameProvider.notifier);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        gameProviderRead.gameRef?.overlays.remove(PauseOverlay.id);
        gameNotifier.resumeGameEngine();
      },
      child: Center(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 3 * 2,
            child: Card(
              color: Colors.white70,
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
                    Text('Your Score is: ${scoreOverlayProviderWatch.score}',
                        style: TextStyle(fontSize: 25)),
                    ElevatedButton(
                      onPressed: () {
                        gameProviderRead.gameRef?.overlays
                            .remove(PauseOverlay.id);
                        gameNotifier.resumeGameEngine();
                      },
                      child: Text('Resume'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        gameNotifier.resumeGameEngine();

                        gameProviderRead.gameRef?.overlays
                            .remove(PauseOverlay.id);
                        gameProviderRead.gameRef?.reset();
                        gameProviderRead.gameRef?.startGame();
                      },
                      child: Text('Restart'),
                    ),
                    ElevatedButton(
                      onPressed: () => SystemNavigator.pop(),
                      child: Text('Exit'),
                    ),
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
