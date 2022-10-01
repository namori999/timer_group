import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timer_group/domein/groupOptionsProvider.dart';
import 'package:timer_group/domein/logic/time_converter.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';

class GroupListItemTile extends ConsumerStatefulWidget {
  const GroupListItemTile({
    required this.timerGroup,
    required this.options,
    required this.timerCount,
    required this.totalTime,
    Key? key,
  }) : super(key: key);

  final TimerGroup timerGroup;
  final TimerGroupOptions options;
  final String timerCount;
  final String totalTime;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      GroupListItemTileState();
}

class GroupListItemTileState extends ConsumerState<GroupListItemTile> {
  TimerGroup get timerGroup => widget.timerGroup;
  TimerGroupOptions get options => widget.options;
  String get timers => widget.timerCount;
  String get totalTime => widget.totalTime;

  String totalTimeText = '';
  String format = '分秒表示';

  @override
  void initState() {
    format = getFormatName(options);
    totalTimeText = getFormattedTime(options, totalTime);
    super.initState();
  }


  Widget separator() {
    return Row(
      children: const [
        SizedBox(
          width: 16,
        ),
        Text('|'),
        SizedBox(
          width: 16,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              timerGroup.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(totalTimeText),
              separator(),
              Row(
                children: [
                  const Icon(Icons.notifications_active_outlined),
                  Text('× $timers'),
                ],
              ),
              separator(),
              Text(format),
            ],
          )),
    );
  }
}
