import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TimeInputDialog extends ConsumerStatefulWidget {
  TimeInputDialog({
    Key? key,
    this.selectedTime,
  }) : super(key: key);

  String? selectedTime;

  @override
  TimeInputDialogState createState() => TimeInputDialogState();
}

class TimeInputDialogState extends ConsumerState<TimeInputDialog> {
  Duration initialTimer = const Duration();

  String? get selectedTime => widget.selectedTime;

  @override
  void initState() {
    super.initState();
    if (selectedTime != '') {
      initialTimer = parseDuration(selectedTime!);
    }
  }

  Duration parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
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
            child: CupertinoTimerPicker(
              mode: CupertinoTimerPickerMode.hms,
              minuteInterval: 1,
              secondInterval: 1,
              initialTimerDuration: initialTimer,
              onTimerDurationChanged: (Duration changedTimer) {
                setState(() {
                  initialTimer = changedTimer;
                });
              },
            )));
  }
}
