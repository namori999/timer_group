import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/provider/timerGroupProvider.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/views/group_list/group_list_item.dart';

class GroupListBodyData extends ConsumerWidget {
  GroupListBodyData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<List<TimerGroup>?> getTimerGroupsList() async {
      final timerGroups =
          await ref.watch(timerGroupRepositoryProvider).getAll();
      return timerGroups;
    }

    Future<TimerGroup> getTimerGroup(int id) async {
      final timerGroup =
          await ref.watch(timerGroupRepositoryProvider).getTimerGroup(id);
      return timerGroup!;
    }

    Widget emptyLayout() {
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
      padding: const EdgeInsets.only(right: 16, left: 16, bottom: 56),
      child: FutureBuilder(
        future: getTimerGroupsList(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> groups) {
          if (groups.hasData) {
            if (groups.data.isEmpty) {
              return emptyLayout();
            }
            return ListView.builder(
              padding: const EdgeInsets.only(top: 16),
              itemCount: groups.data.length,
              itemBuilder: (context, index) {
                return FutureBuilder(
                  future: getTimerGroup(groups.data[index].id!),
                  builder:
                      (BuildContext context, AsyncSnapshot<TimerGroup> tg) {
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
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                );
              },
            );
          } else if (groups.hasError) {
            return ElevatedButton(
              onPressed: () {},
              child: const Text('再読み込み'),
            );
          } else {
            return emptyLayout();
          }
        },
      ),
    );
  }
}
