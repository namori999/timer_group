import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/firebase/firebase_methods.dart';

class AudioPlayButton extends ConsumerStatefulWidget {
  const AudioPlayButton({
    required this.sound,
    Key? key,
  }) : super(key: key);

  final String sound;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => AudioPlayButtonState();
}

class AudioPlayButtonState extends ConsumerState<AudioPlayButton> {
  String get sound => widget.sound;
  String currentText = "start";
  Icon icon = const Icon(Icons.play_arrow_rounded);

  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    player.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            sound,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () async {
            if (currentText == 'start') {
              player.play(UrlSource(sound));
              setState(() {
                icon = const Icon(
                  Icons.pause_outlined,
                );
                currentText = "stop";
              });
            } else {
              player.stop();
              setState(() {
                icon = const Icon(Icons.play_arrow_rounded);
                currentText = "start";
              });
            }
          },
          icon: icon,
        ),
      ],
    );
  }
}

