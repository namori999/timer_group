import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/groupOptionsProvider.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/timerProvider.dart';
import 'package:timer_group/views/components/dialogs/alarm_input_dialog.dart';
import 'package:timer_group/views/components/dialogs/bgm_input_dialog.dart';
import 'package:timer_group/views/components/dialogs/image_input_dialog.dart';
import 'package:timer_group/views/components/dialogs/time_input_dialog.dart';

import '../configure/theme.dart';

class GroupAddPageTimerListTile extends ConsumerStatefulWidget {
  const GroupAddPageTimerListTile({
    this.index,
    required this.title,
    this.timer,
    Key? key,
  }) : super(key: key);
  final int? index;
  final String title;
  final Timer? timer;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      GroupAddPageListTileState();
}

class GroupAddPageListTileState
    extends ConsumerState<GroupAddPageTimerListTile> {
  get index => widget.index;
  get title => widget.title;
  Timer? get timer => widget.timer;

  String time = '';
  AlarmSounds alarm = AlarmSounds.sample;
  String alarmTitle = '';
  AlarmSounds bgm = AlarmSounds.sample;
  String bgmTitle = '';
  BackGroundImages image = BackGroundImages.sample;
  String imageTitle = BackGroundImages.sample.name;
  String notification = 'ON';
  bool isNotifyEnabled = true;

  @override
  void initState() {
    if(mounted) {
      final timer = this.timer;
      if (timer != null) {
        time = timer.time.toString();
        alarmTitle = timer.soundPath;
        bgmTitle = timer.bgmPath;
        imageTitle = timer.imagePath;
        notification = timer.notification;
      }
      setState(() {});
    }
    super.initState();
  }

  Widget spacer() {
    return Column(
      children: const [
        SizedBox(height: 8),
        Divider(
          color: Themes.grayColor,
          height: 2,
        ),
        SizedBox(height: 8),
      ],
    );
  }

  void addTimer() async {
    final repo = ref.watch(timerGroupRepositoryProvider);
    final id = await repo.getId(title);
    final provider = ref.watch(timerRepositoryProvider);

    await provider.addTimer(
        Timer(
            id: id,
            index: index,
            time: int.parse(time),
            soundPath: alarmTitle,
            bgmPath: bgmTitle,
            imagePath: imageTitle,
            notification: notification
        )
    );
  }

  void setResult(){
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final tgRepo = ref.watch(timerGroupRepositoryProvider);
    final repo = ref.watch(timerGroupOptionsRepositoryProvider);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // if you need this
        side: BorderSide(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(index.toString()),
              spacer(),
              Row(
                children: [
                  const Icon(Icons.timer_outlined),
                  const Text("タイム"),
                  const Spacer(),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(130, 40),
                      foregroundColor: Themes.grayColor,
                      side: const BorderSide(
                        color: Themes.grayColor,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: Row(
                      children: [
                        Text(
                          time,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const Icon(Icons.keyboard_arrow_right_rounded),
                      ],
                    ),
                    onPressed: () async {
                      final id = await tgRepo.getId(title);
                      final options = await repo.getOptions(id);
                      String result = await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) {
                          return TimeInputDialog(
                            timeFormat: options!.timeFormat!,
                          );
                        },
                      );
                      setState((){
                        time = result;
                      });
                    }
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.volume_up_outlined),
                  const Text("アラーム音"),
                  const Spacer(),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(130, 40),
                      foregroundColor: Themes.grayColor,
                      side: const BorderSide(
                        color: Themes.grayColor,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: Row(
                      children: [
                        Text(
                          alarmTitle,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.keyboard_arrow_right_rounded),
                      ],
                    ),
                    onPressed: () async {
                      AlarmSounds result = await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) {
                          return AlermInputDialog();
                        },
                      );
                      setState(() {
                        alarm = result;
                        alarmTitle = result.name;
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.music_note_outlined),
                  const Text("BGM"),
                  const Spacer(),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(130, 40),
                      foregroundColor: Themes.grayColor,
                      side: const BorderSide(
                        color: Themes.grayColor,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: Row(
                      children: [
                        Text(
                          alarmTitle,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.keyboard_arrow_right_rounded),
                      ],
                    ),
                    onPressed: () async {
                      AlarmSounds result = await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) {
                          return BgmInputDialog();
                        },
                      );
                      setState(() {
                        bgm = result;
                        bgmTitle = result.name;
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.image_outlined),
                  const Text("背景"),
                  const Spacer(),
                  Container(
                    width: 130,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      image: DecorationImage(
                        image: AssetImage('assets/images/$imageTitle.jpg'),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(130, 40),
                        foregroundColor: Themes.grayColor,
                        side: const BorderSide(
                          color: Themes.grayColor,
                        ),
                      ),
                      onPressed: () async {
                        BackGroundImages result = await showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) {
                            return ImageInputDialog();
                          },
                        );
                        setState(() {
                          image = result;
                          imageTitle = result.name;
                        });
                      },
                      child: Text(''),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.notifications_active_outlined),
                  const Text("通知"),
                  Spacer(),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(130, 40),
                        foregroundColor: Themes.grayColor,
                        side: const BorderSide(
                          color: Themes.grayColor,
                        ),
                      ),
                      child: Text(
                        notification,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        if (isNotifyEnabled) {
                          isNotifyEnabled = false;
                          setState(() {
                            notification = 'OFF';
                          });
                        } else {
                          isNotifyEnabled = true;
                          setState(() {
                            notification = 'ON';
                          });
                        }
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
