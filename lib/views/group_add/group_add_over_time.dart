import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/sound.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/provider/timer_group_options_provider.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'package:timer_group/domein/provider/timer_provider.dart';
import 'package:timer_group/views/components/separoter.dart';
import 'package:timer_group/views/configure/theme.dart';
import 'package:timer_group/views/group_add/group_add_page_timer_list_tile.dart';

class GroupAddOverTime extends ConsumerStatefulWidget {
  GroupAddOverTime({
    required this.groupId,
    Key? key,
  }) : super(key: key);

  int groupId;

  @override
  ConsumerState createState() => GroupAddOverTimeState();
}

class GroupAddOverTimeState extends ConsumerState<GroupAddOverTime> {
  get groupId => widget.groupId;
  String overTimeText = 'OFF';
  bool overTimeEnabled = false;
  String totalTime = '';
  int id = 0;
  var timer;

  Future<Timer?> getOverTimeTimer() async {
    final overTimeTimer =
        await ref.watch(timerRepositoryProvider).getOverTimeTimer(groupId);
    return overTimeTimer;
  }

  @override
  Widget build(BuildContext context) {
    final optionsProvider = ref.watch(timerGroupOptionsRepositoryProvider);
    final timerRepository = ref.read(timerRepositoryProvider);

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
                  await optionsProvider.update(
                    TimerGroupOptions(
                        id: groupId,
                        timeFormat: options.timeFormat,
                        overTime: value ? 'ON' : 'OFF'),
                  );
                  if (value) {
                    timerRepository.addOverTime(Timer(
                      groupId: groupId,
                      number: 0,
                      time: 0,
                      alarm: Sound(name: '', url: ''),
                      bgm: Sound(name: '', url: ''),
                      imagePath: '',
                      notification: 0,
                      isOverTime: 1,
                    ));
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
              FutureBuilder(
                future: getOverTimeTimer(),
                builder: (BuildContext context,
                    AsyncSnapshot<Timer?> overTimeTimer) {
                  if (overTimeTimer.hasData) {
                    return GroupAddPageTimerListTile(
                      number: 0,
                      groupId: id,
                      timer: overTimeTimer.data,
                      overTime: true,
                    );
                  } else {
                    return const Text("データが存在しません");
                  }
                },
              ),
              spacer()
            ],
          ),
      ],
    );
  }
}
