import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/groupOptionsProvider.dart';
import 'package:timer_group/domein/logic/time_converter.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'package:timer_group/views/components/separoter.dart';
import 'package:timer_group/views/components/tg_subtitle_row.dart';
import 'package:timer_group/views/detail/detail_page_list.dart';

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
  final String totalTime;
  final List<Timer> timers;

  @override
  ConsumerState createState() => DetailPageBodyState();
}

class DetailPageBodyState extends ConsumerState<DetailPageBody> {
  TimerGroup get timerGroup => widget.timerGroup;

  TimerGroupOptions get options => widget.options;

  List<Timer> get timers => widget.timers;

  String get totalTime => widget.totalTime;
  String totalTimeText = '';
  String format = '';

  @override
  void initState() {
    totalTimeText = getFormattedTime(options, totalTime);
    format = getFormatName(options);
    super.initState();
  }

  Widget separator() {
    return Row(
      children: const [
        SizedBox(
          width: 16,
        ),
        Text('|'),
        SizedBox(
          width: 16,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: SizedBox(
          height: 800,
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
                subtitle: tgSubtitleRow(
                    totalTimeText, timers.length.toString(), format),
              ),
              if (timerGroup.description == '')
                SizedBox(
                  height: 100,
                  child: Column(
                    children: [
                      spacer(),
                      Text(timerGroup.description.toString(),
                          style: const TextStyle(fontSize: 16)),
                      spacer(),
                    ],
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 16,
                      ),
                      Icon(
                        Icons.notifications_active_outlined,
                        size: 16,
                      ),
                      SizedBox(
                        width: 8,
                      ),
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
                      Text('× ${timers.length}'),
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
              DetailPageList(
                title: timerGroup.title,
                timers: timers,
                options: options,
              ),
              const SizedBox(
                height: 16,
              ),
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
