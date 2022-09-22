import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'package:timer_group/views/configure/theme.dart';

class TimeInputDialog extends ConsumerStatefulWidget {
  TimeInputDialog({Key? key, required this.timeFormat})
      : super(key: key);

  TimeFormat timeFormat;

  @override
  TimeInputDialogState createState() => TimeInputDialogState();
}

class TimeInputDialogState extends ConsumerState<TimeInputDialog> {
  Duration initialTimer = const Duration();

  @override
  void initState() {
    super.initState();
  }

  Widget spacer() {
    return Column(
      children: const [
        SizedBox(height: 16),
        Divider(
          color: Themes.grayColor,
          height: 2,
        ),
        SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      insetPadding: const EdgeInsets.all(16),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            final result =
              initialTimer.toString().split('.').first.padLeft(8, "0");
            Navigator.pop<String>(context, result);
          },
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  '決定',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.timer_outlined),
              SizedBox(
                width: 8,
              ),
              Text('タイマー')
            ],
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close_rounded)),
        ],
      ),
      content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child:CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.hms,
            minuteInterval: 1,
            secondInterval: 1,
            initialTimerDuration: initialTimer,
            onTimerDurationChanged: (Duration changedTimer) {
              setState(() {
                initialTimer = changedTimer;
              });
            },
          )
      )
    );
  }
}
