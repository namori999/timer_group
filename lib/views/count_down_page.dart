import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stream_duration/stream_duration.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'package:timer_group/domein/provider/timerGroupProvider.dart';

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

  int totalTime = 0;
  int timerIndex = 0;
  late Duration remainingTime;
  late StreamDuration streamDuration;

  @override
  void initState() {
    timerIndex = timerIndex;
    streamDuration = StreamDuration(
      Duration(seconds: timers[0].time),
    );

    if (mounted) {
      Future(() async {
        final timerProvider = ref.watch(timerRepositoryProvider);
        totalTime = await timerProvider.getTotal(timerGroup.id!);
      });
    }
    super.initState();
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
              child: Image.asset(
                  'assets/images/${timers[timerIndex].imagePath}.jpg'),
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
                          const Icon(
                            Icons.alarm,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(height: 16),
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
                          SlideCountdown(
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
                            onDone: () {
                              timerIndex++;
                              streamDuration.add(
                                Duration(seconds: timers[timerIndex].time),
                              );
                              streamDuration.play();
                              setState(() {});
                            },
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
