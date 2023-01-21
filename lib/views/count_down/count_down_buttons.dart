import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stream_duration/stream_duration.dart';
import 'package:timer_group/views/count_down_page.dart';

class CountDownPageButtons extends StatefulWidget {
  CountDownPageButtons({
    required this.streamDuration,
    Key? key,
  }) : super(key: key);

  StreamDuration streamDuration;

  @override
  State createState() => CountDownPageButtonsState();
}

class CountDownPageButtonsState extends State<CountDownPageButtons> {
  get streamDuration => widget.streamDuration;
  bool isPause = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 1),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                shape: const CircleBorder(),
                child: const Icon(Icons.close_rounded,color: Colors.white,),
              ),
            ),
          ),
        ),
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 1),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: MaterialButton(
                onPressed: () {
                  isPause = !isPause;
                  if (isPause) {
                    streamDuration.pause();
                    CountDownPageState.bgmPlayer.pause();
                  } else {
                    streamDuration.resume();
                    CountDownPageState.bgmPlayer.resume();
                  }
                  setState(() {});
                },
                shape: const CircleBorder(),
                child: isPause
                    ? const Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.pause_rounded,
                        color: Colors.white,
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
