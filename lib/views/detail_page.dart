import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/provider/timer_group_provider.dart';
import 'package:timer_group/domein/provider/timer_provider.dart';
import 'package:timer_group/views/count_down_page.dart';
import 'package:timer_group/views/group_edit_page.dart';
import 'detail/detail_page_data.dart';

class DetailPage extends ConsumerWidget {
  static Route<DetailPage> route({required int id}) {
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

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: [
          CustomScrollView(
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
                  [DetailPageData(id: id)],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                  child: MaterialButton(
                    onPressed: () async {
                      final timerGroup = await timerGroupProvider.getTimerGroup(id);
                      int? totalTimeSecond = await timerProvider.getTotal(id);
                      var totalTime = 0;
                      if (totalTimeSecond != null) {
                        totalTimeSecond = totalTimeSecond;
                      }
                      Navigator.of(context).push(
                        CountDownPage.route(
                          timerGroup: timerGroup!,
                          options: timerGroup.options!,
                          timers: timerGroup.timers!,
                          totalTimeSecond: totalTime,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.play_arrow_rounded,
                            color: Theme.of(context).primaryColor,
                            size: 24,
                          ),
                          Text(
                            'スタート',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                                fontSize: 16
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
