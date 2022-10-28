import 'package:bitcoin_girl/game/sound_manager_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PushButton extends ConsumerStatefulWidget {
  const PushButton({Key? key}) : super(key: key);

  @override
  ConsumerState<PushButton> createState() => _PushButtonState();
}

class _PushButtonState extends ConsumerState<PushButton> {
  double offset = -5;
  late bool isEnabled;
  late SoundManagerNotifier soundManagerNotifier;


  @override
  void initState() {
    super.initState();
    isEnabled = ref.read(soundManagerProvider).bgmStatus;
    soundManagerNotifier = ref.read(soundManagerProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (detail) {
        setState(() {
          offset = -2;
          isEnabled = !isEnabled;
        });
        isEnabled
            ? soundManagerNotifier.playBackgroundMusic()
            : soundManagerNotifier.pauseBackgroundMusic();
      },
      onTapUp: (detail) {
        setState(() {
          offset = -5;
        });
      },
      child: Container(
        height: 35,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child: Container(
                width: 46,
                height: 30,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black38,
                ),
              ),
            ),
            Positioned(
              top: offset,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                elevation: 20,
                shadowColor: Colors.transparent,
                child: Container(
                  width: 45,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blue,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.music_note,
                      color: isEnabled ? Colors.greenAccent : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
