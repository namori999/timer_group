import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/views/components/dialogs/add_timer_dialog.dart';
import 'package:timer_group/views/configure/theme.dart';
import 'group_add_page_timer_list_tile.dart';

class GroupAddPageTimerList extends ConsumerStatefulWidget {
  GroupAddPageTimerList({required this.title, Key? key}) : super(key: key);

  String title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      GroupAddPageTimerListState();
}

class GroupAddPageTimerListState extends ConsumerState<GroupAddPageTimerList> {
  final timerList = <Widget>[];
  int index = 0;

  get title => widget.title;

  int addIndex() {
    ++index;
    return index;
  }

  @override
  void initState() {
    index = -1;
    addIndex();
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
              padding: EdgeInsets.only(right: 32),
              child: Text(
                '× $index',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                  Timer timer = await showModalBottomSheet(
                      context: context,
                      elevation: 20,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10)),
                      ),
                      builder: (context) {
                        return AddTimerDialog(
                          index: index = addIndex(),
                          title: title,
                        );
                      });
                  setState(() {
                    timerList.add(GroupAddPageTimerListTile(
                      index: index,
                      title: title,
                      timer: timer,
                    ));
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
