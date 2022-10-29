import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/provider/timerGroupProvider.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/views/group_list/group_list_item.dart';

class GroupListBodyData extends ConsumerWidget {
  GroupListBodyData({Key? key}) : super(key: key);

  TimerGroup? timerGroup;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerGroups = ref.watch(savedTimerGroupProvider);

    Future<TimerGroup> getTimerGroup(int index) async {
      final id = timerGroups.value![index].id!;
      final options =
          await ref.watch(timerGroupOptionsRepositoryProvider).getOptions(id);
      final repo = ref.read(timerRepositoryProvider);
      final timers = await repo.getTimers(id);
      final totalTime = await repo.getTotal(id);

      return TimerGroup(
        title: timerGroups.value![index].title,
        description: timerGroups.value![index].description,
        options: options,
        timers: timers,
        totalTime: totalTime,
      );
    }

    if (timerGroups.value == null || timerGroups.value!.isEmpty) {
      return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Spacer(),
              Text("まだ登録されてないよ"),
              Spacer(),
              Text(
                "ここからタイマーグループを追加",
                style: TextStyle(fontSize: 12),
              ),
              Icon(Icons.south_east),
              Spacer(),
            ]),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(right: 8, left: 8),
      child: timerGroups.when(
        data: (tg) => ListView.builder(
          padding: const EdgeInsets.only(top: 16),
          itemCount: tg.length,
          itemBuilder: (context, index) {
            return FutureBuilder(
              future: getTimerGroup(index),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data == null) {
                    return const SizedBox();
                  } else {
                    return GroupListItem(
                      timerGroups.value![index],
                      snapshot.data.options,
                      snapshot.data.totalTime,
                      snapshot.data.timers,
                      index,
                    );
                  }
                } else {
                  return const SizedBox();
                }
              },
            );
          },
        ),
        error: (e, st) => Center(
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('再読み込み'),
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
