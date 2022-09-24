import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/views/group_list/group_list_item.dart';

class GroupListBodyData extends ConsumerWidget {
  const GroupListBodyData(this.timerGroups, {Key? key}) : super(key: key);
  final List<TimerGroup> timerGroups;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (timerGroups.isEmpty) {
      return const Text("まだ登録されてないよ");
    }
    return ListView.separated(
      padding: const EdgeInsets.only(top: 16),
      itemBuilder: (context, index) {
        return GroupListItem(timerGroups[index]);
      },
      separatorBuilder: (context, index) {
        print('separator: $index');
        return const Divider(height: 0.5);
      },
      itemCount: timerGroups.length,
    );
  }
}
