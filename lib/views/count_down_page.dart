import 'dart:core';
import 'dart:ui';
import 'dart:io' as io;

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream_duration/stream_duration.dart';
import 'package:timer_group/domein/logic/notififcation.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'package:flutter/services.dart';
import 'package:timer_group/views/count_down/count_down_text.dart';

import 'count_down/count_down_buttons.dart';

class CountDownPage extends ConsumerStatefulWidget {
  static Route<CountDownPage> route({
    required TimerGroup timerGroup,
    required TimerGroupOptions options,
    required int totalTimeSecond,
    required List<Timer> timers,
    required int mainTotalSecond,
  }) {
    return MaterialPageRoute<CountDownPage>(
      settings: const RouteSettings(name: "/detail"),
      builder: (_) =>
          CountDownPage(
            timerGroup: timerGroup,
            options: options,
            totalTimeSecond: totalTimeSecond,
            timers: timers,
            mainTotalSecond: mainTotalSecond,
          ),
    );
  }

  const CountDownPage({
    Key? key,
    required this.timerGroup,
    required this.options,
    required this.totalTimeSecond,
    required this.timers,
    required this.mainTotalSecond,
  }) : super(key: key);

  final TimerGroup timerGroup;
  final TimerGroupOptions options;
  final int totalTimeSecond;
  final List<Timer> timers;
  final int mainTotalSecond;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => CountDownPageState();
}

class CountDownPageState extends ConsumerState<CountDownPage>
    with TickerProviderStateMixin {
  TimerGroup get timerGroup => widget.timerGroup;

  List<Timer> get timers => widget.timers;

  TimerGroupOptions get options => widget.options;

  int get totalTime => widget.totalTimeSecond;

  int get mainTotalSecond => widget.mainTotalSecond;
  late int remainingTotalTime =
  (timerGroup.options!.overTime == 'ON') ? mainTotalSecond : totalTime;

  int currentIndex = 0;
  late var streamDuration = (StreamDuration(
    Duration(seconds: timers[currentIndex].time),
    onDone: () {
      nextDuration();
    },
  ));

  late var controller = AnimationController(
    vsync: this,
    duration: Duration(seconds: timers[currentIndex].time),
  );

  late var totalTimeStreamDuration = (StreamDuration(
    Duration(seconds: remainingTotalTime),
  ));

  late var totalTimeController = AnimationController(
    vsync: this,
    duration: Duration(seconds: remainingTotalTime),
  );

  final alarmPlayer = AudioPlayer();
  static final bgmPlayer = AudioPlayer();

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    if (timers[currentIndex].bgm.url != '') {
      bgmPlayer.setReleaseMode(ReleaseMode.loop);
      bgmPlayer.play(UrlSource(timers[currentIndex].bgm.url));
    }

    super.initState();
  }

  @override
  void dispose() {
    bgmPlayer.dispose();
    if (remainingTotalTime > 0) {
      alarmPlayer.dispose();
    }
    streamDuration.dispose();
    totalTimeStreamDuration.dispose();
    super.dispose();
  }

  void nextDuration() async {
    ///タイマー終了してすぐ
    if (timers[currentIndex].alarm.url != '') {
      await alarmPlayer.play(UrlSource(timers[currentIndex].alarm.url));
    }

    if (LocalNotification.notificationIsActive(
        timers[currentIndex].notification)) {
      LocalNotification().notify(currentIndex);
    }

    if (!totalTimeController.isDismissed) {
      totalTimeController.stop();

      ///totalTimeを今の分減らして再セット
      remainingTotalTime = remainingTotalTime - timers[currentIndex].time;
      totalTimeController = AnimationController(
        vsync: this,
        duration: Duration(seconds: remainingTotalTime),
      );
    }

    if (currentIndex < timers.length - 1) {
      currentIndex++;

      ///次のtimeをセット
      streamDuration = StreamDuration(
        Duration(seconds: timers[currentIndex].time),
        onDone: () {
          nextDuration();
        },
      );

      ///次のDurationをAnimationControlelerに渡す
      controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: timers[currentIndex].time),
      );

      if (timers[currentIndex].isOverTime == null) {
        ///next alarmをカウントダウン
        controller.reverse(
            from: controller.value == 0.0 ? 1.0 : controller.value);
        print(controller);

        ///totalTimeをControllerに渡す
        totalTimeController = AnimationController(
          vsync: this,
          duration: Duration(seconds: remainingTotalTime),
        );

        print(totalTimeController);
      } else {
        //オーバータイムの時
        controller.forward(from: 0.0);
        print(controller);
        totalTimeStreamDuration.dispose();
        totalTimeController.dispose();
      }

      ///次のbgmを再生
      bgmPlayer.pause();
      if (timers[currentIndex].bgm.url != '') {
        bgmPlayer.play(UrlSource(timers[currentIndex].bgm.url));
      }

      setState(() {});
    } else {
      print('All Done');
      Navigator.pop(context);
    }
  }

  bool getBool(Duration duration) {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: FittedBox(
              fit: BoxFit.cover,
              child: timers[currentIndex].imagePath.startsWith('https')
                  ? Image(
                image: CachedNetworkImageProvider(
                    timers[currentIndex].imagePath),
              )
                  : Image.file(io.File(timers[currentIndex].imagePath))
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 120,
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 1),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius:
                        const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 16),
                          const Icon(
                            Icons.alarm,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(height: 16),

                          (timers[currentIndex].isOverTime == null)
                              ? const Text(
                            'next alarm',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                            ),
                          )
                              : const Text(
                            'over time',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          const SizedBox(height: 8),

                          ///今のタイマーのカウントダウン
                          CountDownText(
                            duration:
                            Duration(seconds: timers[currentIndex].time),
                            animationController: controller,
                            timeFormat: timerGroup.options!.timeFormat ??
                                TimeFormat.hourMinute,
                            textStyle: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                decoration: TextDecoration.none),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              if (timers[currentIndex].isOverTime == null)
                SizedBox(
                  width: 200,
                  height: 100,
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 1),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius:
                          const BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'total',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                              ),
                            ),

                            ///合計時間のカウントダウン
                            CountDownText(
                              duration: totalTimeStreamDuration.duration,
                              textStyle: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  decoration: TextDecoration.none),
                              animationController: totalTimeController,
                              timeFormat: timerGroup.options!.timeFormat ??
                                  TimeFormat.hourMinute,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: CountDownPageButtons(
              streamDuration: streamDuration,
              controller: controller,
              totalTimeController: totalTimeController,
            ),
          ),
        )
      ],
    );
  }
}
