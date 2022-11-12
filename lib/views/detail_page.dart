import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'package:timer_group/domein/provider/timerGroupProvider.dart';
import 'package:timer_group/views/count_down_page.dart';
import 'detail/detail_page_body.dart';

class DetailPage extends ConsumerWidget {
  static Route<DetailPage> route({
    required TimerGroup timerGroup,
    required TimerGroupOptions options,
    required int totalTime,
    required List<Timer> timers,
  }) {
    return MaterialPageRoute<DetailPage>(
      settings: const RouteSettings(name: "/detail"),
      builder: (_) => DetailPage(
        timerGroup: timerGroup,
        options: options,
        totalTime: totalTime,
        timers: timers,
      ),
    );
  }

  const DetailPage({
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
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.edit_outlined,
                ),
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
      floatingActionButton: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: MaterialButton(
            onPressed: () async {
              final totalTimeSecond =
                  await timerProvider.getTotal(timerGroup.id!);
              
              Navigator.of(context).push(
                CountDownPage.route(
                  timerGroup: timerGroup,
                  options: options,
                  timers: timers,
                  totalTimeSecond: totalTimeSecond,
                ),
              );
            },
            color: Theme.of(context).backgroundColor.withOpacity(0.9),
            shape: StadiumBorder(
                side: BorderSide(
                    color: Theme.of(context).primaryColor, width: 4)),
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.play_arrow_rounded,
                    color: Theme.of(context).primaryColor,
                    size: 32,
                  ),
                  Text(
                    'スタート',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
