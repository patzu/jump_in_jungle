import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/game_model.dart';

class PauseOverlay extends StatelessWidget {
  static const String id = 'PauseOverlay';

  const PauseOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameRefModel = context.read<GameModel>();
    return Center(
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
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text('Your Score is: ', style: TextStyle(fontSize: 25)),
                ElevatedButton(
                    onPressed: () {
                      GameModel.instance.resumeGameEngine();
                      gameRefModel.gameRef.overlays.remove(PauseOverlay.id);
                    },
                    child: Text('Resume')),
                ElevatedButton(onPressed: () {}, child: Text('Restart')),
                ElevatedButton(onPressed: () {}, child: Text('Exit')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
