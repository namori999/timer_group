import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'package:timer_group/domein/provider/timerGroupProvider.dart';
import 'package:timer_group/views/count_down_page.dart';
import 'detail/detail_page_body.dart';

class GroupEditPage extends ConsumerWidget {
  static Route<GroupEditPage> route({
    required TimerGroup timerGroup,
    required TimerGroupOptions options,
    required int totalTime,
    required List<Timer> timers,
  }) {
    return MaterialPageRoute<GroupEditPage>(
      settings: const RouteSettings(name: "/edit"),
      builder: (_) => GroupEditPage(
        timerGroup: timerGroup,
        options: options,
        totalTime: totalTime,
        timers: timers,
      ),
    );
  }

  const GroupEditPage({
    Key? key,
    required this.timerGroup,
    required this.options,
    required this.totalTime,
    required this.timers,
  }) : super(key: key);

  final TimerGroup timerGroup;
  final TimerGroupOptions options;
  final int totalTime;
  final List<Timer> timers;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerProvider = ref.watch(timerRepositoryProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            backgroundColor: Theme.of(context).backgroundColor,
            iconTheme: IconThemeData(
              color: Theme.of(context).primaryColor,
            ),
            elevation: 0,
            actions: [
              TextButton(
                onPressed: () {},
                child: Text('完了'),
              )
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                DetailPageBody(
                  timerGroup: timerGroup,
                  options: options,
                  totalTime: totalTime,
                  timers: timers,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
