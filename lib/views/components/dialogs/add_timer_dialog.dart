// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/logic/time_converter.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/provider/timer_provider.dart';
import 'package:timer_group/views/group_add/group_add_page_timer_list_tile.dart';

class AddTimerDialog extends ConsumerWidget {
  AddTimerDialog({
    Key? key,
    required this.index,
    required this.groupId,
    this.overTime,
  }) : super(key: key);

  int index;
  int groupId;
  bool? overTime;

  GlobalKey<GroupAddPageListTileState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(TimersProvider.notifier);

    return Container(
      height: 500,
      margin: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop<bool>(context, false);
                  },
                  icon: const Icon(Icons.close_rounded)),
            ],
          ),
          GroupAddPageTimerListTile(
            index: index,
            groupId: groupId,
            overTime: true,
            key: globalKey,
          ),
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
              timer.addTimer(Timer(
                  groupId: groupId,
                  number: index,
                  time: timeToSecond(GroupAddPageListTileState.time),
                  soundPath: GroupAddPageListTileState.alarmTitle,
                  bgmPath: GroupAddPageListTileState.bgmTitle,
                  imagePath: GroupAddPageListTileState.imageTitle,
                  notification: GroupAddPageListTileState.notification));
              Navigator.pop<bool>(context, true);
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
