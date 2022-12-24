import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/provider/timer_group_options_provider.dart';
import 'package:timer_group/domein/provider/timer_group_provider.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'package:timer_group/views/components/separoter.dart';
import 'package:timer_group/views/configure/theme.dart';
import 'package:timer_group/views/group_add/group_add_page_timer_list_tile.dart';

class GroupAddOverTime extends ConsumerStatefulWidget {
  GroupAddOverTime({
    required this.title,
    this.overTimeTimer,
    Key? key,
  }) : super(key: key);

  String title;
  Timer? overTimeTimer;

  @override
  ConsumerState createState() => GroupAddOverTimeState();
}

class GroupAddOverTimeState extends ConsumerState<GroupAddOverTime> {
  get title => widget.title;
  get overTimeTimer => widget.overTimeTimer;
  String overTimeText = 'OFF';
  bool overTimeEnabled = false;
  String totalTime = '';
  int id = 0;
  var timer;

  @override
  initState() {
    if(overTimeTimer != null) {
      overTimeEnabled = true;
      timer = overTimeTimer;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "オーバータイム",
            ),
            Switch(
                value: overTimeEnabled,
                activeColor: Themes.themeColor,
                onChanged: (bool value) async {
                  final repo = ref.watch(timerGroupRepositoryProvider);
                  id = await repo.getId(title);
                  final optionsProvider =
                      ref.watch(timerGroupOptionsRepositoryProvider);
                  final options = await optionsProvider.getOptions(id);

                  if (value) {
                    await optionsProvider.update(TimerGroupOptions(
                        id: id,
                        title: title,
                        timeFormat: options.timeFormat,
                        overTime: 'ON'));
                  } else {
                    await optionsProvider.update(TimerGroupOptions(
                        id: id,
                        title: title,
                        timeFormat: options.timeFormat,
                        overTime: 'OFF'));
                  }
                  setState(() {
                    overTimeEnabled = value;
                  });
                }),
          ],
        ),
        if (overTimeEnabled)
          Column(
            children: [
              GroupAddPageTimerListTile(
                number: 0,
                groupId: id,
                timer: timer,
              ),
              spacer()
            ],
          ),
      ],
    );
  }
}
