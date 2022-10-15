import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'package:timer_group/domein/timerGroupProvider.dart';
import 'package:timer_group/domein/timerProvider.dart';
import 'package:timer_group/views/configure/theme.dart';
import 'package:timer_group/views/detail_page.dart';
import 'group_list_item_tile.dart';

class GroupListItem extends ConsumerStatefulWidget {
  GroupListItem(
      this.timerGroup, this.options, this.totalTime, this.timers, this.index,
      {Key? key})
      : super(key: key);
  final TimerGroup timerGroup;
  TimerGroupOptions options;
  String totalTime;
  List<Timer> timers;
  int index;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => GroupListItemState();
}

class GroupListItemState extends ConsumerState<GroupListItem> {
  TimerGroup get timerGroup => widget.timerGroup;

  TimerGroupOptions get options => widget.options;

  String get totalTime => widget.totalTime;

  List<Timer> get timers => widget.timers;

  int get index => widget.index;

  @override
  void initState() {
    super.initState();
  }

  void showCancelAlert() {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('グループを削除します'),
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
                  Navigator.pop(context);
                }),
          ],
        );
      },
    );
  }

  Future<void> removeGroup() async {
    final repo = ref.watch(timerGroupRepositoryProvider);
    final timerProvider = ref.watch(timerRepositoryProvider);
    final id = await repo.getId(timerGroup.title);
    await repo.removeTimerGroup(id);
    await timerProvider.removeAllTimers(id);
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
            foregroundColor: Themes.grayColor,
            icon: Icons.edit_outlined,
            label: '編集',
          ),
          SlidableAction(
            onPressed: (_) {
              showCancelAlert();
            },
            foregroundColor: Colors.red,
            icon: Icons.delete_outline,
            label: '削除',
          ),
        ],
      ),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              DetailPage.route(
                timerGroup: timerGroup,
                options: options,
                timers: timers,
                totalTime: totalTime,
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
