import 'package:flutter/cupertino.dart';
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
  final timerList = <Widget>[];
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
      index = timers.length;
      for (Timer t in timers) {
        if (t.number != 0) {
          timerList.add(GroupAddPageTimerListTile(
            index: t.number,
            groupId: t.groupId,
            timer: t,
          ));
        }
      }
    } else {
      index = -1;
      addIndex();
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
            const Text("タイマー"),
            Padding(
              padding: const EdgeInsets.only(right: 32),
              child: Text(
                '× $index',
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
            children: [
              Row(
                children: timerList,
              ),
              IconButton(
                onPressed: () async {
                  final timerProvider = ref.watch(TimersProvider.notifier);

                  index = addIndex();
                  bool timerAdded = await showModalBottomSheet(
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

                  if (!timerAdded) {
                    timerProvider.removeTimer(groupId, index);
                    setState(() {
                      index = index - 1;
                    });
                  } else {
                    final timer = await ref
                        .read(timerRepositoryProvider)
                        .getTimer(groupId, index);

                    setState(() {
                      timerList.add(GroupAddPageTimerListTile(
                        index: index,
                        groupId: groupId,
                        timer: timer,
                      ));
                    });
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
