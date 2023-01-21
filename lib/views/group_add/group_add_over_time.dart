import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/provider/timer_group_options_provider.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'package:timer_group/views/components/separoter.dart';
import 'package:timer_group/views/configure/theme.dart';
import 'package:timer_group/views/group_add/group_add_page_timer_list_tile.dart';

class GroupAddOverTime extends ConsumerStatefulWidget {
  GroupAddOverTime({
    required this.groupId,
    this.overTimeTimer,
    Key? key,
  }) : super(key: key);

  int groupId;
  Timer? overTimeTimer;

  @override
  ConsumerState createState() => GroupAddOverTimeState();
}

class GroupAddOverTimeState extends ConsumerState<GroupAddOverTime> {
  get groupId => widget.groupId;

  get overTimeTimer => widget.overTimeTimer;
  String overTimeText = 'OFF';
  bool overTimeEnabled = false;
  String totalTime = '';
  int id = 0;
  var timer;

  @override
  initState() {
    if (overTimeTimer != null) {
      overTimeEnabled = true;
      timer = overTimeTimer;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final optionsProvider = ref.watch(timerGroupOptionsRepositoryProvider);

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
                  final options = await optionsProvider.getOptions(groupId);

                  if (value) {
                    await optionsProvider.update(
                      TimerGroupOptions(
                          id: groupId,
                          timeFormat: options.timeFormat,
                          overTime: value ? 'ON' : 'OFF'),
                    );
                    setState(() {
                      overTimeEnabled = value;
                    });
                  }
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
                overTime: true,
              ),
              spacer()
            ],
          ),
      ],
    );
  }
}
