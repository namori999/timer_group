import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'package:timer_group/views/configure/theme.dart';

class TimeInputDialog extends ConsumerStatefulWidget {
  TimeInputDialog({ Key? key, required this.timeFormat}) : super(key: key);

  TimeFormat timeFormat;

  @override
  TimeInputDialogState createState() => TimeInputDialogState();
}

class TimeInputDialogState extends ConsumerState<TimeInputDialog> {
  get timeFormat => widget.timeFormat;
  TimeFormat format = TimeFormat.minuteSecond;

  String firstUnit = '';
  String secondUnit ='';
  String firstText = '';
  String secondText = '';

  @override
  void initState() {
    format = timeFormat;
    formatToString();
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

  void formatToString() {
    var format = timeFormat;
    if (format == TimeFormat.minuteSecond) {
      firstUnit = '分';
      secondUnit = '秒';
    } else {
      firstUnit = '時間';
      secondUnit = '分';
    }
  }

  PinTheme pinTheme() {
    return PinTheme(
      shape: PinCodeFieldShape.box,
      borderRadius: BorderRadius.circular(5),
      fieldHeight: 50,
      fieldWidth: 40,
      activeFillColor: Colors.white,
      selectedColor: Themes.grayColor[500],
      selectedFillColor: Themes.grayColor[100],
      inactiveFillColor: Colors.white,
      inactiveColor: Themes.grayColor[500],
    );
  }

  @override
  Widget build(BuildContext context) {
    StreamController<ErrorAnimationType> errorController =
        StreamController<ErrorAnimationType>.broadcast();
    final TextEditingController firstTextController = TextEditingController();
    final TextEditingController secondTextController = TextEditingController();

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
            final result ='$firstText$firstUnit$secondText$secondUnit';
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
      title: Container(
        alignment: Alignment.centerRight,
        child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close_rounded)),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [Icon(Icons.timer_outlined), Text('タイマー')],
            ),
            const SizedBox(
              height: 34,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Container(
                  width: 86,
                  child: PinCodeTextField(
                    length: 2,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: pinTheme(),
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    errorAnimationController: errorController,
                    controller: firstTextController,
                    keyboardType: TextInputType.number,
                    autoDismissKeyboard: true,
                    textCapitalization: TextCapitalization.none,
                    onCompleted: (v) {
                      print("Completed");
                    },
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        firstText = value;
                      });
                    },
                    appContext: context,
                  ),
                ),
                const Spacer(),
                Text(firstUnit),
                Spacer(),
                Container(
                  width: 86,
                  child: PinCodeTextField(
                    length: 2,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: pinTheme(),
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    errorAnimationController: errorController,
                    controller: secondTextController,
                    keyboardType: TextInputType.number,
                    autoDismissKeyboard: true,
                    textCapitalization: TextCapitalization.none,
                    onCompleted: (v) {
                      print("Completed");
                    },
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        secondText = value;
                      });
                    },
                    appContext: context,
                  ),
                ),
                Spacer(),
                Text(secondUnit),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
