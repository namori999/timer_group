import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/logic/undo_stack.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'package:timer_group/domein/provider/timerGroupProvider.dart';
import 'package:timer_group/views/detail_page.dart';
import 'group_list_item_tile.dart';

class GroupListItem extends ConsumerStatefulWidget {
  GroupListItem(
      this.timerGroup, this.options, this.totalTime, this.timers, this.index,
      {Key? key})
      : super(key: key);
  final TimerGroup timerGroup;
  TimerGroupOptions options;
  int totalTime;
  List<Timer> timers;
  int index;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => GroupListItemState();
}

class GroupListItemState extends ConsumerState<GroupListItem> {
  TimerGroup get timerGroup => widget.timerGroup;

  TimerGroupOptions get options => widget.options;

  int get totalTime => widget.totalTime;

  List<Timer> get timers => widget.timers;

  int get index => widget.index;

  final undo = UndoStack();

  void setUndo(TimerGroup group) async {
    final provider = ref.watch(timerGroupRepositoryProvider);
    undo.push(() {
      provider.recoverTimerGroup(timerGroup: group);
    });
  }

  void removeGroup() {
    final group = TimerGroup(
      id: timerGroup.id,
      title: timerGroup.title,
      description: timerGroup.title,
      options: options,
      timers: timers,
      totalTime: totalTime,
    );

    final provider = ref.watch(timerGroupRepositoryProvider);
    setUndo(group);
    provider.removeTimerGroup(group.id!);

    final snackBar = SnackBar(
      content: Text('${group.title}を削除しました'),
      action: SnackBarAction(
        label: '取り消し',
        onPressed: () {
          if (undo.isNotEmpty) {
            undo.undo();
          }
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      dragStartBehavior: DragStartBehavior.start,
      key: UniqueKey(),
      endActionPane: ActionPane(
        extentRatio: 0.5,
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (_) {},
            foregroundColor: Theme.of(context).primaryColor,
            backgroundColor: Theme.of(context).backgroundColor,
            icon: Icons.edit_outlined,
            label: '編集',
          ),
          SlidableAction(
            onPressed: (_) {
              removeGroup();
            },
            foregroundColor: Theme.of(context).errorColor,
            backgroundColor: Theme.of(context).backgroundColor,
            icon: Icons.delete_outline,
            label: '削除',
          ),
        ],
      ),
      child: Card(
        elevation: 3,
        shadowColor: Theme.of(context).shadowColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              DetailPage.route(
                id: timerGroup.id!,
              ),
            );
          },
          borderRadius: BorderRadius.circular(10),
          child: GroupListItemTile(
            timerGroup: timerGroup,
            options: options,
            timers: timers,
            totalTime: totalTime,
          ),
        ),
      ),
    );
  }
}
