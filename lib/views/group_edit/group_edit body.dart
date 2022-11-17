import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/views/detail/detail_page_body.dart';

class GroupEditPageBody extends ConsumerStatefulWidget {
  GroupEditPageBody({
    required this.timerGroup,
    Key? key,
  }) : super(key: key);

  TimerGroup timerGroup;

  @override
  ConsumerState createState() => GroupEditPageBodyState();
}

class GroupEditPageBodyState extends ConsumerState<GroupEditPageBody> {
  TimerGroup get timerGroup => widget.timerGroup;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DetailPageBody(
            timerGroup: timerGroup,
            options: timerGroup.options!,
            totalTime: timerGroup.totalTime!,
            timers: timerGroup.timers!)
      ],
    );
  }
}
