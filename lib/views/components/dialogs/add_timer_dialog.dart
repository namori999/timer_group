import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/domein/provider/timer_group_provider.dart';
import 'package:timer_group/domein/provider/timer_provider.dart';
import 'package:timer_group/firebase/firebase_methods.dart';
import 'package:timer_group/views/group_add/group_add_page_timer_list.dart';
import 'package:timer_group/views/group_add/group_add_page_timer_list_tile.dart';

class AddTimerDialog extends ConsumerWidget {
  AddTimerDialog({
    Key? key,
    required this.index,
    required this.groupId,
    required this.timer,
    this.overTime,
  }) : super(key: key);

  int index;
  int groupId;
  Timer timer;
  bool? overTime;

  GlobalKey<GroupAddPageListTileState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(timerRepositoryProvider);
    final watchedTimer = ref.watch(singleTimerProvider(timer));

    Future<TimerGroup> getTimerGroup(int id) async {
      final timerGroup =
          await ref.watch(timerGroupRepositoryProvider).getTimerGroup(id);
      return timerGroup!;
    }

    return Container(
      height: 600,
      margin: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    provider.removeTimer(groupId, index);
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close_rounded)),
            ],
          ),
          watchedTimer.when(
              data: (d) => GroupAddPageTimerListTile(
                    index: index,
                    groupId: groupId,
                    overTime: true,
                    timer: d,
                    key: globalKey,
                  ),
              error: (e, s) => const SizedBox(),
              loading: () => const Center(
                    child: CircularProgressIndicator(),
                  )),
          const SizedBox(
            height: 16,
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () async {
              final timerGroup = await getTimerGroup(groupId);
              FirebaseMethods().saveToFireStore(timerGroup);

              final scrollController = ref.read(scrollControllerProvider);
              scrollController.jumpTo(
                scrollController.position.maxScrollExtent,
              );
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'タイマーを追加',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
