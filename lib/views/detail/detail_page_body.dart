import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:timer_group/domein/logic/time_converter.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'package:timer_group/domein/provider/timerGroupOptionsProvider.dart';
import 'package:timer_group/views/components/separoter.dart';
import 'package:timer_group/views/detail/detail_page_list.dart';
import 'package:timer_group/views/detail/over_time_tile.dart';

class DetailPageBody extends ConsumerStatefulWidget {
  DetailPageBody({
    required this.timerGroup,
    required this.options,
    Key? key,
  }) : super(key: key);

  TimerGroup timerGroup;
  TimerGroupOptions options;

  @override
  ConsumerState createState() => DetailPageBodyState();
}

class DetailPageBodyState extends ConsumerState<DetailPageBody> {
  TimerGroup get timerGroup => widget.timerGroup;
  TimerGroupOptions get options => widget.options;

  List<Timer> timers = [];

  String totalTimeText = '';
  String format = '';
  String timerCount = '';

  @override
  void initState() {
    totalTimeText =
        getFormattedTime(options, timerGroup.totalTime!);
    format = getFormatName(options);
    timers = timerGroup.timers!;

    if (options.overTime == 'ON') {
      timerCount = (timers.length - 1).toString();
    } else {
      timerCount = timers.length.toString();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 24, left: 24, bottom: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Column(
              children: [
                Text(
                  timerGroup.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                if (timerGroup.description != "" ||
                    timerGroup.description != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      timerGroup.description.toString(),
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
          spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "表示単位",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              Text(getFormatName(options)),
            ],
          ),
          spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.notifications_active_outlined, size: 16),
                  SizedBox(width: 8),
                  Text(
                    'タイマー',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  )
                ],
              ),
              Text('× $timerCount'),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
              height: 300,
              child: DetailPageList(
                title: timerGroup.title,
                timers: timers,
                options: options,
              )),
          const SizedBox(
            height: 16,
          ),
          spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'オーバータイム',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              Text(options.overTime.toString()),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          if (options.overTime == 'ON')
            SizedBox(
              height: 300,
              child: OverTimeTile(
                title: timerGroup.title,
                timer: timers.last,
                options: options,
              ),
            ),
          const  SizedBox(
            height: 56,
          )
        ],
      ),
    );
  }
}
