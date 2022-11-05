import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'package:timer_group/views/configure/theme.dart';
import 'detail/detail_page_body.dart';

class DetailPage extends ConsumerWidget {
  static Route<DetailPage> route({
    required TimerGroup timerGroup,
    required TimerGroupOptions options,
    required String totalTime,
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
  final String totalTime;
  final List<Timer> timers;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            backgroundColor: Theme.of(context).colorScheme.background,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit_outlined),
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
      floatingActionButton: MaterialButton(
        onPressed: () {},
        shape: const StadiumBorder(
            side: BorderSide(color: Colors.white, width: 4)),
        color: Themes.themeColor.shade900.withOpacity(0.7),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.play_arrow_rounded,
                color: Colors.white,
                size: 32,
              ),
              Text(
                'スタート',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
