import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jungler/notifiers/game_notifier.dart';
import 'package:jungler/notifiers/sound_manager_notifier.dart';

class SettingOverlay extends ConsumerStatefulWidget {
  static String id = 'SettingOverlay';

  @override
  ConsumerState<SettingOverlay> createState() {
    return _SettingOverlayState();
  }
}

class _SettingOverlayState extends ConsumerState<SettingOverlay> {
  late bool _isJumpSoundOn;
  late bool _isBackgroundMusicOn;
  late bool _isHurtSoundOn;
  late SoundManagerNotifier soundManagerNotifier;

  @override
  void initState() {
    final soundManagerRead = ref.read(soundManagerProvider);
    soundManagerNotifier = ref.read(soundManagerProvider.notifier);

    _isJumpSoundOn = soundManagerRead.isJumpSoundPlaying;
    _isBackgroundMusicOn = soundManagerRead.isBackgroundMusicPlaying;
    _isHurtSoundOn = soundManagerRead.isHurtSoundPlaying;
  }

  @override
  Widget build(BuildContext context) {
    final gameProviderRead = ref.read(gameProvider);
    final gameNotifier = ref.read(gameProvider.notifier);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        gameProviderRead.gameRef!.overlays.remove(SettingOverlay.id);
        gameNotifier.resumeGameEngine();
      },
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 3 * 2,
          color: Colors.white70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  gameProviderRead.gameRef!.overlays.remove(SettingOverlay.id);
                  gameNotifier.resumeGameEngine();
                },
              ),
              SwitchListTile(
                title: const Text('Jump Sound'),
                value: _isJumpSoundOn,
                onChanged: (bool value) {
                  setState(() {
                    _isJumpSoundOn = value;
                  });
                  soundManagerNotifier.setIsJumpSoundPlaying(value);
                },
                secondary: const Icon(Icons.lightbulb_outline),
              ),
              SwitchListTile(
                title: const Text('Hurt Sound'),
                value: _isHurtSoundOn,
                onChanged: (bool value) {
                  setState(() {
                    _isHurtSoundOn = value;
                  });
                  soundManagerNotifier.setIsHurtSoundPlaying(value);
                },
                secondary: const Icon(Icons.lightbulb_outline),
              ),
              SwitchListTile(
                title: const Text('Background Music'),
                value: _isBackgroundMusicOn,
                onChanged: (bool value) {
                  setState(() {
                    _isBackgroundMusicOn = value;
                  });
                  value
                      ? soundManagerNotifier.resumeBackgroundMusic()
                      : soundManagerNotifier.pauseBackgroundMusic();
                },
                secondary: const Icon(Icons.lightbulb_outline),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
