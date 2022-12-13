import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/provider/timer_provider.dart';
import 'package:timer_group/views/components/dialogs/add_timer_dialog.dart';
import 'package:timer_group/views/configure/theme.dart';
import 'group_add_page_timer_list_tile.dart';

class GroupAddPageTimerList extends ConsumerStatefulWidget {
  GroupAddPageTimerList({
    required this.groupId,
    this.timers,
    Key? key,
  }) : super(key: key);

  List<Timer>? timers;
  int groupId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      GroupAddPageTimerListState();
}

class GroupAddPageTimerListState extends ConsumerState<GroupAddPageTimerList> {
  static final timerList = <Widget>[];
  static int index = 0;

  get groupId => widget.groupId;

  get timers => widget.timers;

  int addIndex() {
    ++index;
    return index;
  }

  @override
  void initState() {
    if (timers != null) {
      int index = 1;
      for (Timer t in timers) {
        if (t.number != 0) {
          timerList.add(GroupAddPageTimerListTile(
            index: index,
            number: t.number,
            groupId: t.groupId,
            timer: t,
          ));
          index ++;
        }
      }
    } else {
      addIndex();
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    timerList.clear();
  }

  @override
  Widget build(BuildContext context) {
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
              child: Text(
                '× ${timerList.length}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                height: 380,
                child: Row(
                  children: timerList,
                )
              ),
              IconButton(
                onPressed: () async {
                  final timerProvider = ref.watch(timerRepositoryProvider);
                  index = addIndex();
                  Timer addedTimer = await showModalBottomSheet(
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
                        );
                      });

                  if (addedTimer == null) {
                    timerProvider.removeTimer(groupId, index);
                    setState(() {
                      index = index - 1;
                    });
                  } else {
                    final timer = await timerProvider.getTimer(groupId, index);
                    timerList.add(GroupAddPageTimerListTile(
                      index: index,
                      number: index,
                      groupId: groupId,
                      timer: timer,
                    ));
                  }
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
  }
}
