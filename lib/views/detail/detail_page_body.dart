import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';


class DetailPageBody extends ConsumerWidget {
  DetailPageBody({
    required this.timerGroup,
    required this.options,
    this.timers,
    required this.totalTime,
    Key? key,
  })  : super(key: key);

  final TimerGroup timerGroup;
  final TimerGroupOptions options;
  List<Timer>? timers;
  final String totalTime;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [],
    );
  }
}

