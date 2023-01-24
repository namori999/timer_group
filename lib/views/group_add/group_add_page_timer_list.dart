import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/sound.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/provider/timer_provider.dart';
import 'package:timer_group/firebase/firebase_methods.dart';
import 'package:timer_group/views/components/dialogs/add_timer_dialog.dart';
import 'package:timer_group/views/configure/theme.dart';
import 'group_add_page_timer_list_tile.dart';

class GroupAddPageTimerList extends ConsumerStatefulWidget {
  GroupAddPageTimerList({
    required this.groupId,
    required this.overTimeEnabled,
    this.timers,
    Key? key,
  }) : super(key: key);

  List<Timer>? timers;
  bool overTimeEnabled;
  int groupId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      GroupAddPageTimerListState();
}

class GroupAddPageTimerListState extends ConsumerState<GroupAddPageTimerList> {
  static final timerList = <Widget>[];
  static int index = 0;

  get groupId => widget.groupId;

  get overTimeEnabled => widget.overTimeEnabled;

  get timers => widget.timers;

  String imageTitle = '';

  @override
  void initState() {
    Future(() async {
      final sampleImageTitle = await FirebaseMethods().getSampleImageTitle();
      imageTitle = sampleImageTitle;
    });
    super.initState();
  }

  int addIndex() {
    ++index;
    return index;
  }

  @override
  Widget build(BuildContext context) {
    final timerRepository = ref.watch(timerRepositoryProvider);
    final timersProvider = ref.watch(timersListProvider(groupId));
    return timersProvider.when(
      data: (d) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("タイマー"),
                Padding(
                  padding: const EdgeInsets.only(right: 32),
                  child: overTimeEnabled
                      ? Text(
                          '× ${d!.length - 1}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      : Text(
                          '× ${d!.length}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 360,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          overTimeEnabled ? timers.length - 1 : timers.length,
                      itemBuilder: (context, i) {
                        if (timers[i].isOverTime == 1) {
                          return const SizedBox();
                        } else {
                          return GroupAddPageTimerListTile(
                            index: i + 1,
                            number: timers[i].number,
                            groupId: groupId,
                            timer: timers[i],
                          );
                        }
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      index = addIndex();
                      timerRepository.addTimer(
                        Timer(
                            groupId: groupId,
                            number: index,
                            time: 0,
                            alarm: Sound(name: '', url: ''),
                            bgm: Sound(name: '', url: ''),
                            imagePath: imageTitle,
                            notification: 0),
                      );

                      final timer = await ref
                          .watch(timerRepositoryProvider)
                          .getTimer(groupId, index);

                      await showModalBottomSheet(
                          context: context,
                          elevation: 20,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(10)),
                          ),
                          builder: (context) {
                            return AddTimerDialog(
                              index: index,
                              groupId: groupId,
                              timer: timer,
                            );
                          });
                    },
                    iconSize: 80,
                    icon: const Icon(
                      Icons.add_circle_outline_rounded,
                      color: Themes.grayColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
      error: (e, s) => const SizedBox(),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
