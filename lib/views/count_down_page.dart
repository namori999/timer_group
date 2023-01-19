import 'dart:core';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:stream_duration/stream_duration.dart';
import 'package:timer_group/domein/logic/notififcation.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';

class CountDownPage extends ConsumerStatefulWidget {
  static Route<CountDownPage> route({
    required TimerGroup timerGroup,
    required TimerGroupOptions options,
    required int totalTimeSecond,
    required List<Timer> timers,
  }) {
    return MaterialPageRoute<CountDownPage>(
      settings: const RouteSettings(name: "/detail"),
      builder: (_) => CountDownPage(
        timerGroup: timerGroup,
        options: options,
        totalTimeSecond: totalTimeSecond,
        timers: timers,
      ),
    );
  }

  const CountDownPage({
    Key? key,
    required this.timerGroup,
    required this.options,
    required this.totalTimeSecond,
    required this.timers,
  }) : super(key: key);

  final TimerGroup timerGroup;
  final TimerGroupOptions options;
  final int totalTimeSecond;
  final List<Timer> timers;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => CountDownPageState();
}

class CountDownPageState extends ConsumerState<CountDownPage> {
  TimerGroup get timerGroup => widget.timerGroup;
  List<Timer> get timers => widget.timers;
  TimerGroupOptions get options => widget.options;
  int get totalTime => widget.totalTimeSecond;

  late Duration remainingTime;
  Duration duration = const Duration(seconds: 0);
  int currentIndex = 0;
  late var streamDuration = (StreamDuration(
    Duration(seconds: timers[currentIndex].time),
    onDone: () {
      nextDuration();
    },
  ));

  late Image backGroundImage = Image(
    image: CachedNetworkImageProvider(timers[currentIndex].imagePath),
  );

  final alarmPlayer = AudioPlayer();
  final bgmPlayer = AudioPlayer();

  @override
  void initState() {
    bgmPlayer.setReleaseMode(ReleaseMode.loop);
    bgmPlayer.play(UrlSource(timers[currentIndex].bgm.url));
    super.initState();
  }

  @override
  void dispose() {
    bgmPlayer.dispose();
    alarmPlayer.dispose();
    super.dispose();
  }

  void nextDuration() {
    ///タイマー終了してすぐ
    LocalNotification().notify(currentIndex);
    alarmPlayer.play(UrlSource(timers[currentIndex].alarm.url));

    if (currentIndex < timers.length - 1) {
      currentIndex++;
      ///次のtimeをセット
      streamDuration = StreamDuration(
        Duration(seconds: timers[currentIndex].time),
        onDone: () {
          nextDuration();
        },
      );
      ///次のbgmを再生
      bgmPlayer.pause();
      bgmPlayer.play(UrlSource(timers[currentIndex].bgm.url));
      ///次の背景に更新
      setState(() {
        backGroundImage = Image(
          image: CachedNetworkImageProvider(timers[currentIndex].imagePath),
        );
      });
    } else {
      print('All Done');
      bgmPlayer.stop();
      bgmPlayer.dispose();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Image(
                image:
                    CachedNetworkImageProvider(timers[currentIndex].imagePath),
              ),
            ),
          ),
          Center(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 1),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 16),
                          const Icon(
                            Icons.alarm,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(height: 16),
                          ///合計時間のカウントダウン
                          SlideCountdown(
                            duration: Duration(seconds: totalTime),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            textStyle: const TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              fontSize: 36,
                            ),
                            onDone: () {
                              print('Countdown done!');
                            },
                          ),
                          const Divider(
                            color: Colors.white,
                            height: 36,
                            thickness: 1,
                          ),
                          const Text(
                            '次のアラームまで',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ///今のタイマーのカウントダウン
                          SlideCountdown(
                            key: UniqueKey(),
                            duration: streamDuration.duration,
                            streamDuration: streamDuration,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            textStyle: const TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
