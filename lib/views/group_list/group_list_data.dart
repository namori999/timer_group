
import 'package:flutter/cupertino.dart';
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
    return ListView.builder(
      itemCount: timerGroups.length,
      itemBuilder: (context, index) {
        return GroupListItem(timerGroups[index]);
      },
    );
  }
}
