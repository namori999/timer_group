import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/sound.dart';
import 'package:timer_group/domein/provider/audioProvider.dart';
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

  AudioPlayer get player => widget.player;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
  }

  void setStartIcon() {
    icon = const Icon(Icons.play_arrow_rounded);
    setState(() {});
  }

  void setPauseIcon() {
    icon = const Icon(Icons.pause_rounded);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final audioProvider = ref.watch(audioPlayingProvider.notifier);
    player.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.playing) {
        print('playing');
      }
      if (state == PlayerState.paused) {
        print('paused');
        setStartIcon();
      }
    });

    void start() {
      isPlaying = true;
      audioProvider.play(sound);
      setPauseIcon();
    }

    void pause() {
      audioProvider.pause();
      isPlaying = false;
    }

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
          onPressed: () {
            (player.state == PlayerState.playing) ? pause() : start();
          },
          child: icon,
        ),
      ],
    );
  }
}