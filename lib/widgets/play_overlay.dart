import 'package:bitcoin_girl/models/game_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayOverlay extends StatelessWidget {
  static String id = 'PauseModal';

  const PlayOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameRefModel = context.read<GameModel>();

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
                print('Play overlay: ${gameRefModel.gameRef.hashCode}');
                print('Play overlay: ${GameModel.instance.gameRef.hashCode}');

                gameRefModel.gameRef.startGame();
                gameRefModel.gameRef.overlays.remove(PlayOverlay.id);
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
