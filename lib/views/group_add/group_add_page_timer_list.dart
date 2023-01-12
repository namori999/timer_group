import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer.dart';
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
                '× ${timers.length}',
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
                height: 360,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: timers.length,
                  itemBuilder: (context, i) {
                    return GroupAddPageTimerListTile(
                      index: i +1,
                      number: timers[i].number,
                      groupId: groupId,
                      timer: timers[i],
                    );
                  },
                ),
              ),
              IconButton(
                onPressed: () async {
                  index = addIndex();
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
  }
}
