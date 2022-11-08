import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/provider/timerGroupProvider.dart';
import 'package:timer_group/domein/logic/time_converter.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'package:timer_group/views/components/separoter.dart';
import 'package:timer_group/views/components/tg_subtitle_row.dart';
import 'package:timer_group/views/detail/detail_page_list.dart';
import 'package:timer_group/views/detail/over_time_tile.dart';

class DetailPageBody extends ConsumerStatefulWidget {
  DetailPageBody({
    required this.timerGroup,
    required this.options,
    required this.totalTime,
    required this.timers,
    Key? key,
  }) : super(key: key);

  final TimerGroup timerGroup;
  final TimerGroupOptions options;
  final int totalTime;
  final List<Timer> timers;

  @override
  ConsumerState createState() => DetailPageBodyState();
}

class DetailPageBodyState extends ConsumerState<DetailPageBody> {
  TimerGroup get timerGroup => widget.timerGroup;

  TimerGroupOptions get options => widget.options;

  List<Timer> get timers => widget.timers;

  int get totalTime => widget.totalTime;
  String totalTimeText = '';
  String format = '';
  String timerCount = '';

  double topHeight = 0;

  @override
  void initState() {
    totalTimeText = getFormattedTime(options, totalTime);
    format = getFormatName(options);
    if (options.overTime == 'ON') {
      timerCount = (timers.length - 1).toString();
    } else {
      timerCount = timers.length.toString();
    }
    topHeight = timerGroup.description != null ? 180 : 100;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: SizedBox(
          height: 1200,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    timerGroup.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                subtitle: Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  alignment: AlignmentDirectional.topStart,
                  child: Column(
                    children: [
                      tgSubtitleRow(totalTimeText, timerCount, format),
                      if (timerGroup.description != "" ||
                          timerGroup.description != null)
                        Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          alignment: AlignmentDirectional.topStart,
                          child: Column(
                            children: [
                              spacer(),
                              Text(
                                timerGroup.description.toString(),
                                textAlign: TextAlign.left,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(width: 16),
                      Icon(Icons.notifications_active_outlined, size: 16),
                      SizedBox(width: 8),
                      Text(
                        'タイマー',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('× $timerCount'),
                      const SizedBox(
                        width: 16,
                      ),
                    ],
                  ),
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        'オーバータイム',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(options.overTime.toString()),
                      const SizedBox(
                        width: 32,
                      ),
                    ],
                  ),
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
              const Expanded(
                child: SizedBox(
                  height: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
