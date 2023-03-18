import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timer_group/domein/provider/timer_group_options_provider.dart';
import 'package:timer_group/domein/logic/time_converter.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'package:timer_group/domein/provider/timer_provider.dart';
import 'package:timer_group/views/configure/theme.dart';

class GroupListItemTile extends ConsumerStatefulWidget {
  const GroupListItemTile({
    required this.timerGroup,
    required this.options,
    required this.timers,
    required this.totalTime,
    Key? key,
  }) : super(key: key);

  final TimerGroup timerGroup;
  final TimerGroupOptions options;
  final List<Timer> timers;
  final int totalTime;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      GroupListItemTileState();
}

class GroupListItemTileState extends ConsumerState<GroupListItemTile> {
  TimerGroup get timerGroup => widget.timerGroup;

  TimerGroupOptions get options => widget.options;

  List<Timer> get timers => widget.timers;

  int get totalTime => widget.totalTime;

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
    final timersProvider = ref.watch(timersListProvider(timerGroup.id!));
    final timerCount = timersProvider.valueOrNull?.length;

    final overTimeTimer = timers.where((t) => t.isOverTime == 1).toList();
    if (overTimeTimer.isNotEmpty) {
      totalTimeText =
          getFormattedTime(options, totalTime - overTimeTimer.first.time);
    } else {
      totalTimeText = getFormattedTime(options, totalTime);
    }
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
              if (timerCount != null)
                Row(
                  children: [
                    const Icon(
                      Icons.notifications_active_outlined,
                      color: Themes.grayColor,
                    ),
                    Text('× $timerCount'),
                  ],
                ),
              separator(),
              Text(format),
            ],
          )),
    );
  }
}
