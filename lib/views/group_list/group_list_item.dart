import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/timerProvider.dart';
import 'package:timer_group/views/detail_page.dart';
import 'group_list_item_tile.dart';

class GroupListItem extends ConsumerStatefulWidget {
  GroupListItem(this.timerGroup, this.options, {Key? key}) : super(key: key);
  final TimerGroup timerGroup;
  TimerGroupOptions options;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => DeckListItemState();
}

class DeckListItemState extends ConsumerState<GroupListItem> {
  TimerGroup get timerGroup => widget.timerGroup;

  TimerGroupOptions get options => widget.options;
  String totalTime = '';
  List<Timer> timers =[];

  @override
  void initState() {
    super.initState();
  }

  Future<List<Timer>> getTimers() async {
    final repo = ref.read(timerRepositoryProvider);
    final id = timerGroup.id;
    final timers = await repo.getTimers(id!);
    this.timers = timers;
    final totalTime = await repo.getTotal(id);
    this.totalTime = totalTime;
    return timers;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: FutureBuilder<List<Timer>>(
        future: getTimers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              return Text('no data');
            } else {
              return InkWell(
                onTap: () => Navigator.of(context).push(DetailPage.route()),
                borderRadius: BorderRadius.circular(10),
                child: GroupListItemTile(
                  timerGroup: timerGroup,
                  options: options,
                  timers: timers,
                  totalTime: totalTime,
                ),
              );
            }
          } else {
            return CircularProgressIndicator(); // loading
          }
        },
      ),
    );
  }
}
