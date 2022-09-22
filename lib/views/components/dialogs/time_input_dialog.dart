import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'package:timer_group/views/configure/theme.dart';

class TimeInputDialog extends ConsumerStatefulWidget {
  TimeInputDialog({Key? key, required this.timeFormat, required this.title})
      : super(key: key);

  TimeFormat timeFormat;
  String title;

  @override
  TimeInputDialogState createState() => TimeInputDialogState();
}

class TimeInputDialogState extends ConsumerState<TimeInputDialog> {
  get timeFormat => widget.timeFormat;
  get title => widget.title;
  TimeFormat format = TimeFormat.minuteSecond;

  String firstUnit = '';
  String secondUnit = '';
  String firstText = '';
  String secondText = '';

  StreamController<ErrorAnimationType>? errorController;
  bool hasError = false;

  @override
  void initState() {
    formatToString();
    errorController = StreamController<ErrorAnimationType>.broadcast();
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
      activeFillColor:  hasError ? Colors.red : Colors.white,
      selectedColor: Themes.grayColor[500],
      selectedFillColor: Themes.grayColor[100],
      inactiveFillColor: Colors.white,
      inactiveColor: Themes.grayColor[500],
    );
  }

  @override
  Widget build(BuildContext context) {
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
            final result = '$firstText$firstUnit$secondText$secondUnit';
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
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 86,
                  child: PinCodeTextField(
                    length: 2,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: pinTheme(),
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    controller: firstTextController,
                    keyboardType: TextInputType.number,
                    autoDismissKeyboard: true,
                    textCapitalization: TextCapitalization.none,
                    onCompleted: (v) {
                        setState(() {
                          firstText = v;
                        });
                    },
                    onChanged: (value) {
                    },
                    appContext: context,
                  ),
                ),
                const Spacer(),
                Text(firstUnit),
                Spacer(),
                SizedBox(
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
                      if (int.parse(v) > 59) {
                        errorController?.add(ErrorAnimationType
                            .shake);
                        Fluttertoast.showToast(
                            msg: "$secondUnitの入力は 59まで できます",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        return;
                      } else {
                        hasError = false;
                        setState(() {
                          secondText = v;
                        });
                      }
                    },
                    onChanged: (value) {

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
