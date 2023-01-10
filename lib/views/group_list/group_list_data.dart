import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/provider/timer_group_provider.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/views/group_list/group_list_item.dart';

class GroupListBodyData extends ConsumerWidget {
  GroupListBodyData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerGroups = ref.watch(savedTimerGroupProvider);

    Future<TimerGroup> getTimerGroup(int id) async {
      final timerGroup =
          await ref.watch(timerGroupRepositoryProvider).getTimerGroup(id);
      return timerGroup!;
    }

    Widget emptyLayout() {
      return Center(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Spacer(),
              Text(
                "+ ボタンから",
                style: TextStyle(fontSize: 12),
              ),
              Text(
                "タイマーグループを追加します",
                style: TextStyle(fontSize: 12),
              ),
              Icon(Icons.south_east),
              Spacer(),
            ]),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, bottom: 56),
      child: Center(
        child: timerGroups.when(
          loading: () => const CircularProgressIndicator(),
          data: (groups) {
            return (groups.isEmpty)
                ? emptyLayout()
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 16),
                    itemCount: groups.length,
                    itemBuilder: (context, index) {
                      return FutureBuilder(
                        future: getTimerGroup(groups[index].id!),
                        builder: (BuildContext context,
                            AsyncSnapshot<TimerGroup> tg) {
                          if (tg.hasData) {
                            return GroupListItem(
                              tg.data!,
                              tg.data!.options!,
                              tg.data!.totalTime!,
                              tg.data!.timers!,
                              index,
                            );
                          } else if (tg.hasError) {
                            return const SizedBox();
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
                      );
                    },
                  );
          },
          error: (error, stackTrace) {
            return emptyLayout();
          },
        ),
      ),
    );
  }
}
