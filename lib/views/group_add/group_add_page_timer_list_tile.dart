import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/provider/timerGroupProvider.dart';
import 'package:timer_group/domein/logic/time_converter.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/firebase/firebase_methods.dart';
import 'package:timer_group/views/components/dialogs/alarm_input_dialog.dart';
import 'package:timer_group/views/components/dialogs/bgm_input_dialog.dart';
import 'package:timer_group/views/components/dialogs/background_input_dialog/image_input_dialog.dart';
import 'package:timer_group/views/components/dialogs/time_input_dialog.dart';

import '../configure/theme.dart';

class GroupAddPageTimerListTile extends ConsumerStatefulWidget {
  GroupAddPageTimerListTile({
    this.index,
    required this.title,
    this.timer,
    this.overTime,
    Key? key,
  }) : super(key: key);

  final int? index;
  final String title;
  final Timer? timer;
  bool? overTime;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      GroupAddPageListTileState();
}

class GroupAddPageListTileState
    extends ConsumerState<GroupAddPageTimerListTile> {
  get index => widget.index;

  get title => widget.title;

  Timer? get timer => widget.timer;

  static String time = '';
  AlarmSounds alarm = AlarmSounds.sample;
  static String alarmTitle = '';
  AlarmSounds bgm = AlarmSounds.sample;
  static String bgmTitle = '';
  Image image = Image.asset('sample.jpg');
  static String imageTitle = BackGroundImages.sample.name;
  static String notification = 'ON';
  bool isNotifyEnabled = true;
  String timerRowText = 'タイマー';
  String alarmRowText = 'アラーム';

  @override
  void initState() {
    final timer = this.timer;

    if (timer != null) {
      time = intToTimeLeft(timer.time);
      alarmTitle = timer.soundPath;
      bgmTitle = timer.bgmPath;
      imageTitle = timer.imagePath;
      notification = timer.notification;
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

  Timer getTImer() {
    var timer = Timer(
        groupId: 0,
        number: index,
        time: timeToSecond(time),
        soundPath: alarmTitle,
        bgmPath: bgmTitle,
        imagePath: imageTitle,
        notification: notification);
    return timer;
  }

  Future<Timer?> addTimer() async {
    if (mounted) {
      final repo = ref.watch(timerGroupRepositoryProvider);
      final id = await repo.getId(title);
      var timer = Timer(
          groupId: id,
          number: index,
          time: timeToSecond(time),
          soundPath: alarmTitle,
          bgmPath: bgmTitle,
          imagePath: imageTitle,
          notification: notification);

      final provider = ref.watch(timerRepositoryProvider);
      await provider.addTimer(timer);
      return timer;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
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
              if (index != 0)
                Column(
                  children: [
                    Text(index.toString()),
                    spacer(),
                  ],
                ),
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
                        Duration result = await showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) {
                            return TimeInputDialog(
                              selectedTime: time,
                            );
                          },
                        );
                        final timerProvider =
                            ref.watch(timerRepositoryProvider);
                        timerProvider
                            .update(timer!.copyWith(time: result.inSeconds));
                        setState(() {
                          time = result
                              .toString()
                              .split('.')
                              .first
                              .padLeft(8, "0");
                        });
                      }),
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
                          return const AlarmInputDialog();
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
                          bgmTitle,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.keyboard_arrow_right_rounded),
                      ],
                    ),
                    onPressed: () async {
                      AlarmSounds sounds = await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) {
                          return const BgmInputDialog();
                        },
                      );
                      setState(() {
                        bgm = sounds;
                        bgmTitle = sounds.name;
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
                        image: CachedNetworkImageProvider(imageTitle),
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
                        final List<Image> imageList =
                            await FirebaseMethods().getImages();
                        String result = await showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) {
                            return ImageInputDialog(imageList);
                          },
                        );
                        imageTitle = result;

                        setState(() {
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
