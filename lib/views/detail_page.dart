import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/domein/provider/timerGroupProvider.dart';
import 'package:timer_group/views/count_down_page.dart';
import 'package:timer_group/views/group_edit_page.dart';
import 'detail/detail_page_body.dart';

class DetailPage extends ConsumerWidget {
  static Route<DetailPage> route({
    required int id
  }) {
    return MaterialPageRoute<DetailPage>(
      settings: const RouteSettings(name: "/detail"),
      builder: (_) => DetailPage(
        id: id,
      ),
    );
  }

  const DetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerProvider = ref.watch(timerRepositoryProvider);
    final timerGroupProvider = ref.watch(timerGroupRepositoryProvider);

    Future<TimerGroup?> getTimerGroup() async{
      final timerGroupProvider = ref.watch(timerGroupRepositoryProvider);
      final timerGroup = await timerGroupProvider.getTimerGroup(id);
      return timerGroup;
    }

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
                onPressed: () async {
                  final timerGroup = await timerGroupProvider.getTimerGroup(id);
                  Navigator.push(
                      context,
                      GroupEditPage.route(
                        timerGroup: timerGroup!,
                        options: timerGroup.options!,
                        timers: timerGroup.timers!,
                        totalTime: timerGroup.totalTime!,
                      ));
                },
                icon: const Icon(
                  Icons.edit_outlined,
                ),
              )
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                FutureBuilder(
                  future: getTimerGroup(),
                  builder: (BuildContext context, AsyncSnapshot<TimerGroup?> snapshot) {
                    if (snapshot.hasData) {
                    return DetailPageBody(timerGroup: snapshot.data!);
                    } else {
                    return Text("データが存在しません");
                    }
                  },
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
              final timerGroup = await timerGroupProvider.getTimerGroup(id);
              final totalTimeSecond =
                  await timerProvider.getTotal(id);

              Navigator.of(context).push(
                CountDownPage.route(
                  timerGroup: timerGroup!,
                  options: timerGroup.options!,
                  timers: timerGroup.timers!,
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
