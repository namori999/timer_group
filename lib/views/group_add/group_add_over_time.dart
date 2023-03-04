import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/sound.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/provider/timer_group_options_provider.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'package:timer_group/domein/provider/timer_provider.dart';
import 'package:timer_group/firebase/firebase_methods.dart';
import 'package:timer_group/views/components/separoter.dart';
import 'package:timer_group/views/configure/theme.dart';
import 'package:timer_group/views/group_add/group_add_page_timer_list_tile.dart';

class GroupAddOverTime extends ConsumerStatefulWidget {
  GroupAddOverTime({
    required this.groupId,
    required this.overTimeEnabled,
    Key? key,
  }) : super(key: key);

  int groupId;
  bool overTimeEnabled;

  @override
  ConsumerState createState() => GroupAddOverTimeState();
}

class GroupAddOverTimeState extends ConsumerState<GroupAddOverTime> {
  get groupId => widget.groupId;
  String overTimeText = 'OFF';

  get overTimeEnabled => widget.overTimeEnabled;
  String totalTime = '';
  int id = 0;
  var timer;
  String imageTitle = '';

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
                  final sampleImageTitle =
                      await FirebaseMethods().getSampleImageTitle();
                  imageTitle = sampleImageTitle;

                  await optionsProvider.update(
                    TimerGroupOptions(
                        id: groupId,
                        timeFormat: options.timeFormat,
                        overTime: value ? 'ON' : 'OFF'),
                  );
                  if (value) {
                    timerRepository.addOverTime(
                      Timer(
                        groupId: groupId,
                        number: 10000,
                        time: 0,
                        alarm: Sound(name: '', url: ''),
                        bgm: Sound(name: '', url: ''),
                        imagePath: imageTitle,
                        notification: 0,
                        isOverTime: 1,
                      ),
                    );
                  } else {
                    timerRepository.removeOverTime(id);
                  }
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
                      number: overTimeTimer.data!.number,
                      groupId: id,
                      timer: overTimeTimer.data!,
                      overTime: overTimeEnabled,
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
