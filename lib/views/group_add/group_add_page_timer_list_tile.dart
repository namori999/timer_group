import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/logic/time_converter.dart';
import 'package:timer_group/domein/models/sound.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/provider/timer_provider.dart';
import 'package:timer_group/firebase/firebase_methods.dart';
import 'package:timer_group/views/components/dialogs/alarm_input_dialog.dart';
import 'package:timer_group/views/components/dialogs/bgm_input_dialog.dart';
import 'package:timer_group/views/components/dialogs/background_input_dialog/image_input_dialog.dart';
import 'package:timer_group/views/components/dialogs/time_input_dialog.dart';

import '../configure/theme.dart';
import 'group_add_page_timer_list.dart';

class GroupAddPageTimerListTile extends ConsumerStatefulWidget {
  GroupAddPageTimerListTile({
    this.number,
    this.index,
    required this.groupId,
    this.timer,
    this.overTime,
    Key? key,
  }) : super(key: key);

  final int? number;
  final int? index;
  final int groupId;
  final Timer? timer;
  bool? overTime;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      GroupAddPageListTileState();
}

class GroupAddPageListTileState
    extends ConsumerState<GroupAddPageTimerListTile> {
  get number => widget.number;

  get index => widget.index;

  get groupId => widget.groupId;

  Timer? get timer => widget.timer;
  bool? get overTime => widget.overTime;

  /*
  static String time = '';
  static int timeSecond = 0;
  static Sound alarm = Sound(name: '', url: '');
  static Sound bgm = Sound(name: '', url: '');
  static String alarmTitle = '';
  static String bgmTitle = '';
  static String imageTitle = '';
  static bool notification = false;
  String timerRowText = 'タイマー';
  String alarmRowText = 'アラーム';
   */

  /*
  @override
  void initState() {
    final timer = this.timer;
    if (timer != null) {
      time = intToTimeLeft(timer.time);
      alarmTitle = timer.alarm.name;
      bgmTitle = timer.alarm.name;
      imageTitle = timer.imagePath;
      notification = LocalNotification.notificationIsActive(timer.notification);
    } else {
      time = '00:00:00';
      Future(() async {
        final sampleImageTitle = await FirebaseMethods().getSampleImageTitle();
        imageTitle = sampleImageTitle;
        setState(() {});
      });
    }
    super.initState();
  }
   */

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

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(timerRepositoryProvider);

    return SizedBox(
      width: 280,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // if you need this
          side: BorderSide(
            color: Colors.grey.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: InkWell(
          onTap: () => print('${timer!.number}'),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (overTime != true)
                  Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Center(
                            child: Text(index.toString()),
                          ),
                          Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: IconButton(
                              onPressed: () async {
                                provider.removeTimer(groupId, number);
                                GroupAddPageTimerListState.timerList
                                    .removeAt(index);
                                setState(() {});
                              },
                              icon: const Icon(Icons.close_rounded),
                              padding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
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
                              (timer != null)
                                  ? intToTimeLeft(timer!.time)
                                  : '',
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
                                selectedTime: (timer != null)
                                    ? intToTimeLeft(timer!.time)
                                    : '00:00:00',
                              );
                            },
                          );

                          if (timer != null) {
                            provider.updateTimer(
                                timer!.copyWith(time: result.inSeconds));
                          }
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
                        maximumSize: const Size(130, 40),
                        foregroundColor: Themes.grayColor,
                        side: const BorderSide(
                          color: Themes.grayColor,
                        ),
                        padding: const EdgeInsets.all(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 80,
                            child: Text(
                              (timer != null) ? timer!.alarm.name : '',
                              maxLines: 1,
                              softWrap: false,
                              overflow: TextOverflow.fade,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.keyboard_arrow_right_rounded),
                        ],
                      ),
                      onPressed: () async {
                        List<Sound> sounds =
                            await FirebaseMethods().getSoundEffects();

                        Sound result = await showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) {
                            return AlarmInputDialog(sounds: sounds);
                          },
                        );

                        if (timer != null) {
                          provider.updateTimer(timer!.copyWith(
                            alarm: Sound(name: result.name, url: result.url),
                          ));
                        }
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
                          SizedBox(
                            width: 80,
                            child: Text(
                              (timer != null) ? timer!.bgm.name : '',
                              maxLines: 1,
                              softWrap: false,
                              overflow: TextOverflow.fade,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.keyboard_arrow_right_rounded),
                        ],
                      ),
                      onPressed: () async {
                        final List<Sound> musics =
                            await FirebaseMethods().getSoundEffects();
                        Sound result = await showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) {
                            return BgmInputDialog(musics: musics);
                          },
                        );
                        if (timer != null) {
                          provider.updateTimer(timer!.copyWith(
                              bgm: Sound(name: result.name, url: result.url)));
                        }
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
                      decoration: (timer != null)
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    timer!.imagePath),
                                fit: BoxFit.fitWidth,
                              ),
                            )
                          : null,
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
                          if (timer != null) {
                            provider.updateTimer(
                                timer!.copyWith(imagePath: result));
                          }

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
                          (timer != null && timer!.notification == true)
                              ? 'ON'
                              : 'OFF',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          if (timer != null && timer!.notification == 'ON') {
                            //OFFにする
                            if (timer != null) {
                              provider.updateTimer(
                                  timer!.copyWith(notification: 0));
                            }
                          } else {
                            //ONにする
                            if (timer != null) {
                              provider.updateTimer(
                                  timer!.copyWith(notification: 1));
                            }
                          }
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
