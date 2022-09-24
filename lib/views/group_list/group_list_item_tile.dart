import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';


class GroupListItemTile extends ConsumerWidget {
  const GroupListItemTile(
      this.timerGroup, this.options, this.timers,
       {
        Key? key,
      }) : super(key: key);
  final TimerGroup timerGroup;
  final TimerGroupOptions options;
  final List<Timer> timers;

  String getFormatName() {
    if (options.timeFormat == TimeFormat.minuteSecond) {
      return '分秒表示';
    } else {
      return '時分表示';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Padding(
      padding: const EdgeInsets.only(left: 10),
        child: ListTile(
          title: Text(timerGroup.title,style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('|'),
              Row(
                children: [
                  const Icon(Icons.notifications_active_outlined),
                  Text('× ${timers.length}'),
                ],
              ),
              Text('|'),
              Text(getFormatName()),
            ],
          )
        ),
    );
  }
}
