import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/views/configure/theme.dart';

import 'group_add_page_timer_list_tile.dart';

class GroupAddPageTimerList extends ConsumerStatefulWidget {
  const GroupAddPageTimerList({Key key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      GroupAddPageTimerListState();
}

class GroupAddPageTimerListState extends ConsumerState<GroupAddPageTimerList> {
  final timerList = <Widget>[];
  int index = 0;

  int addIndex() {
    ++index;
    return index;
  }

  @override
  void initState() {
    super.initState();
    timerList.add(GroupAddPageTimerListTile(addIndex()));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Row(
            children: timerList,
          ),
          IconButton(
            onPressed: () => setState(() {
              timerList.add(GroupAddPageTimerListTile(addIndex()));
            }),
            iconSize: 80,
            icon: const Icon(
              Icons.add_circle_outline,
              color: Themes.grayColor,
            ),
          ),
        ],
      ),
    );
  }
}
