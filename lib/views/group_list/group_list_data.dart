import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/groupOptionsProvider.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'package:timer_group/views/group_list/group_list_item.dart';

class GroupListBodyData extends ConsumerWidget {
  const GroupListBodyData(this.timerGroups, {Key? key}) : super(key: key);
  final List<TimerGroup> timerGroups;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<TimerGroupOptions> _getFutureValue(int index) async {
      final id = timerGroups[index].id!;
      final option =
          await ref.watch(timerGroupOptionsRepositoryProvider).getOptions(id);
      return option;
    }

    if (timerGroups.isEmpty) {
      return const Text("まだ登録されてないよ");
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 16),
      itemCount: timerGroups.length,
      itemBuilder: (context, index) {
        return FutureBuilder(
          future: _getFutureValue(index),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null) {
                return Text('no data');
              } else {
                return GroupListItem(timerGroups[index], snapshot.data);
              }
            } else {
              return Center(child: CircularProgressIndicator()); // loading
            }
          },
        );
      },
    );
  }
}
