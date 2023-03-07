
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';

class CountDownText extends StatefulWidget {
  CountDownText({
    required this.duration,
    required this.timeFormat,
    required this.animationController,
    required this.textStyle,
  }) : super();

  final Duration duration;
  final TimeFormat timeFormat;
  final AnimationController animationController;
  final TextStyle textStyle;

  @override
  CountDownTextState createState() => CountDownTextState();
}

class CountDownTextState extends State<CountDownText> {
  Duration get duration => widget.duration;

  TimeFormat get timeFormat => widget.timeFormat;

  AnimationController get controller => widget.animationController;

  TextStyle? get textStyle => widget.textStyle;

  String get timerString {
    Duration duration = controller.duration! * controller.value;
    if (timeFormat == TimeFormat.hourMinute) {
      return '${duration.inHours}:'
          '${(duration.inMinutes % 60).toString().padLeft(2, '0')}:'
          '${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    }
    return '${duration.inMinutes}:'
        '${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    print(duration);
    controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);
  }

  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 250,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                timerString,
                style: textStyle,
              ),
            ],
          );
        },
      ),
    );
  }
}
