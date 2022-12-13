import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/sound.dart';
import 'package:timer_group/views/configure/theme.dart';

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
  bool isPlaying = false;

  AudioPlayer get player => widget.player;

  @override
  void initState() {
    super.initState();
    player.setReleaseMode(ReleaseMode.loop);
    player.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.paused) {
        toggleIcon();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    player.stop();
  }

  void toggleIcon() {
    if (isPlaying) {
      icon = const Icon(Icons.pause_outlined);
    } else {
      icon = const Icon(Icons.play_arrow_rounded);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            sound.name,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        const Spacer(),
        ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(const CircleBorder()),
            backgroundColor: MaterialStateProperty.all(
                Themes.grayColor.shade50), // <-- Button color
          ),
          onPressed: () async {
            if (isPlaying) {
              player.pause();
              isPlaying = false;
            } else {
              if (player.state == PlayerState.playing) {
                await player.pause();
                player.play(UrlSource(sound.url));
              } else {
                player.play(UrlSource(sound.url));
              }
              isPlaying = true;
            }
            toggleIcon();
          },
          child: icon,
        ),
      ],
    );
  }
}
