import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';

class CountDownText extends StatefulWidget {
  CountDownText({
    required this.duration,
    required this.timeFormat,
    required this.animationController,
  }) : super();

  final Duration duration;
  final TimeFormat timeFormat;
  final AnimationController animationController;

  @override
  CountDownTextState createState() => CountDownTextState();
}

class CountDownTextState extends State<CountDownText> {
  Duration get duration => widget.duration;
  TimeFormat get timeFormat => widget.timeFormat;
  AnimationController get controller => widget.animationController;


  String get timerString {
    Duration duration = controller.duration! * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    print(duration);
    controller.reverse(
        from: controller.value == 0.0
            ? 1.0
            : controller.value);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 250,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                timerString,
                style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
              /*
              AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    return FloatingActionButton.extended(
                        onPressed: () {
                          if (controller.isAnimating)
                            controller.stop();
                          else {
                            controller.reverse(
                                from: controller.value == 0.0
                                    ? 1.0
                                    : controller.value);
                          }
                        },
                        icon: Icon(controller.isAnimating
                            ? Icons.pause
                            : Icons.play_arrow),
                        label: Text(
                            controller.isAnimating ? "Pause" : "Play"));
                  }),

               */
            ],
          );
        },
      ),
    );
  }
}
