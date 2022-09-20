import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timer_group/domein/groupOptionsProvider.dart';
import 'package:timer_group/domein/models/timer_group.dart';


class GroupListItemTile extends ConsumerWidget {
  const GroupListItemTile(
      this.timerGroup, {
        Key? key,
      }) : super(key: key);
  final TimerGroup timerGroup;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(timerGroupOptionsRepositoryProvider);
    final options =   repo.getOptions(timerGroup.id!);


    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: ListTile(
        title: Text(timerGroup.title),
      ),
    );
  }
}
