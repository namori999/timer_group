import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/timerGroupProvider.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'package:timer_group/domein/timerProvider.dart';
import 'package:timer_group/views/group_list/group_list_item.dart';

class GroupListBodyData extends ConsumerStatefulWidget {
  GroupListBodyData(this.timerGroups, {Key? key}) : super(key: key);
  final List<TimerGroup> timerGroups;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      GroupListBodyDataState();
}

class GroupListBodyDataState extends ConsumerState<GroupListBodyData> {
  List<TimerGroup> get timerGroups => widget.timerGroups;
  TimerGroup? timerGroup;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    Future<TimerGroup> getTimerGroup(int index) async {
      final id = timerGroups[index].id!;
      final options =
          await ref.watch(timerGroupOptionsRepositoryProvider).getOptions(id);
      final repo = ref.read(timerRepositoryProvider);
      final timers = await repo.getTimers(id);
      final totalTime = await repo.getTotal(id);

      return TimerGroup(
          title: timerGroups[index].title,
          description: timerGroups[index].description,
          options: options,
          timers: timers,
          totalTime: totalTime);
    }

    if (timerGroups.isEmpty) {
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

    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            onRefresh: () async {
              setState(() {});
              setState(() {
                _isLoading = false;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8, left: 8),
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 16),
                itemCount: timerGroups.length,
                itemBuilder: (context, index) {
                  return FutureBuilder(
                    future: getTimerGroup(index),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data == null) {
                          _isLoading = false;
                          return const SizedBox();
                        } else {
                          _isLoading = false;
                          return GroupListItem(
                            timerGroups[index],
                            snapshot.data.options,
                            snapshot.data.totalTime,
                            snapshot.data.timers,
                            index,
                          );
                        }
                      } else {
                        _isLoading = true;
                        return const SizedBox();
                      }
                    },
                  );
                },
              ),
            ),
          );
  }
}
