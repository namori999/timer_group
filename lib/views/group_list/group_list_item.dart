import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'package:timer_group/views/detail_page.dart';
import 'group_list_item_tile.dart';

class GroupListItem extends ConsumerStatefulWidget {
  GroupListItem(this.timerGroup, this.options, this.timerCount, this.totalTime,
      {Key? key})
      : super(key: key);
  final TimerGroup timerGroup;
  TimerGroupOptions options;
  String timerCount;
  String totalTime;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => DeckListItemState();
}

class DeckListItemState extends ConsumerState<GroupListItem> {
  TimerGroup get timerGroup => widget.timerGroup;

  TimerGroupOptions get options => widget.options;

  String get timerCount => widget.timerCount;

  String get totalTime => widget.totalTime;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          DetailPage.route(
            timerGroup: timerGroup,
            options: options,
            totalTime: totalTime,
          ),
        ),
        borderRadius: BorderRadius.circular(10),
        child: GroupListItemTile(
          timerGroup: timerGroup,
          options: options,
          timerCount: timerCount,
          totalTime: totalTime,
        ),
      ),
    );
  }
}
