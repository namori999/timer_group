import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timer_group/views/components/separoter.dart';

Widget tgSubtitleRow(String totalTimeText, String timerCount, String format) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(totalTimeText),
      textSeparator(),
      Row(
        children: [
          const Icon(Icons.notifications_active_outlined),
          Text('× $timerCount'),
        ],
      ),
      textSeparator(),
      Text(format),
    ],
  );
}
