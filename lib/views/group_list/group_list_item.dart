import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/logic/undo_stack.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'package:timer_group/domein/provider/timer_group_provider.dart';
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
    final provider = ref.watch(savedTimerGroupProvider.notifier);
    undo.push(() {
      provider.recoverGroup(group);
    });
  }

  void showRemoveAlert(String title) {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('$titleを削除します'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('キャンセル'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoDialogAction(
                child: const Text(
                  '削除',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () async {
                  removeGroup();
                  Navigator.pop(this.context);
                }),
          ],
        );
      },
    );
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

    final provider = ref.watch(savedTimerGroupProvider.notifier);
    setUndo(group);
    provider.removeGroup(group.id!);

    final snackBar = SnackBar(
      content: Text('${group.title}を削除しました'),
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
            backgroundColor: Theme.of(context).colorScheme.background,
            icon: Icons.edit_outlined,
            label: '編集',
          ),
          SlidableAction(
            onPressed: (_) {
              showRemoveAlert(timerGroup.title);
            },
            foregroundColor: Theme.of(context).colorScheme.error,
            backgroundColor: Theme.of(context).colorScheme.background,
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
