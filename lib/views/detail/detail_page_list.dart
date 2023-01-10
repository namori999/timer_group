import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'detail_page_list_tile.dart';

class DetailPageList extends ConsumerStatefulWidget {
  DetailPageList(
      {required this.title,
      required this.timers,
      required this.options,
      Key? key})
      : super(key: key);

  String title;
  List<Timer> timers;
  TimerGroupOptions options;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => DetailPageListState();
}

class DetailPageListState extends ConsumerState<DetailPageList> {
  List<Timer> timerList = [];

  get title => widget.title;

  get timers => widget.timers;

  get options => widget.options;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (options.overTime == 'ON') {
      return  Scrollbar(
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 16),
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: timers.length,
            itemBuilder: (context, index) {
              return DetailPageListTile(
                title: title,
                timer: timers[index],
                options: options,
                index: index,
              );
            },
          ),
      );
    }

    return Scrollbar(
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 16),
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: timers.length,
        itemBuilder: (context, index) {
          return DetailPageListTile(
            title: title,
            timer: timers[index],
            options: options,
            index: index,
          );
        },
      ),
    );
  }
}
