import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/sound.dart';
import 'package:timer_group/views/configure/theme.dart';
import 'audioProvider.dart';

class AudioPlayButton extends ConsumerStatefulWidget {
  const AudioPlayButton({
    required this.sound,
    required this.player,
    Key? key,
  }) : super(key: key);

  final Sound sound;
  final AudioPlayer player;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => AudioPlayButtonState();
}

class AudioPlayButtonState extends ConsumerState<AudioPlayButton> {
  Sound get sound => widget.sound;
  Icon icon = const Icon(Icons.play_arrow_rounded);

  AudioPlayer get player => widget.player;
  bool isPlaying = false;
  static bool isSelected = false;

  @override
  void dispose() {
    ref.watch(audioPlayingProvider.notifier).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final audioProvider = ref.watch(audioPlayingProvider.notifier);
    final audioProviderIcon = ref.watch(audioIconProvider);

    return GestureDetector(
      onTap: () {
        audioProvider.play(player, sound);
        isPlaying = !isPlaying;
        isSelected = !isSelected;

        if (isPlaying) {
          icon = const Icon(Icons.pause_rounded);
        } else {
          icon = const Icon(Icons.play_arrow_rounded);
        }
        setState(() {});
      },
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  sound.name.substring(0, sound.name.indexOf('.')),
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                      color: (isSelected ||
                          audioProvider.currentPlayer.playerId != player.playerId)
                          ? Theme.of(context).textTheme.bodyMedium!.color
                          : Themes.themeColor
                  ),
                ),
              ),
              audioProviderIcon
            ],
          ),
        ],
      ),
    );
  }
}
