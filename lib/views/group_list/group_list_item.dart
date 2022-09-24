
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/groupOptionsProvider.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/timerProvider.dart';
import 'group_list_item_tile.dart';

class GroupListItem extends ConsumerStatefulWidget {
  const GroupListItem(this.timerGroup, {Key? key}) : super(key: key);
  final TimerGroup timerGroup;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => DeckListItemState();
}

class DeckListItemState extends ConsumerState<GroupListItem> {
  TimerGroup get timerGroup => widget.timerGroup;
  TimerGroupOptions options = TimerGroupOptions(id: 0, title:'');
  List<Timer> timers = [];

  @override
  void initState() {
    if(mounted){
      getOptions();
      getTimers();
    }
    super.initState();
  }

  void getOptions() async {
    final repo = ref.read(timerGroupOptionsRepositoryProvider);
    final id = timerGroup.id;
    options = (await repo.getOptions(id!))!;
  }

  void getTimers() async{
    final repo = ref.read(timerRepositoryProvider);
    final id = timerGroup.id;
    timers = await repo.getTimers(id!);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: (){},
        child:GroupListItemTile(timerGroup,options,timers),
    );
  }
}
