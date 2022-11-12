import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsCountDownView extends ConsumerStatefulWidget {
  static Route<SettingsCountDownView> route() {
    return MaterialPageRoute<SettingsCountDownView>(
      settings: const RouteSettings(name: "/detail"),
      builder: (_) => SettingsCountDownView(),
    );
  }

  const SettingsCountDownView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      SettingsCountDownViewState();
}

class SettingsCountDownViewState extends ConsumerState<SettingsCountDownView> {
  String selectedValue = '';

  @override
  void initState() {
    setState(() {
      selectedValue = '大きめ';
    });
    super.initState();
  }

  _onRadioSelected(value) {
    setState(() {
      selectedValue = value;
    });
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
            Navigator.pop<String>(context, selectedValue);
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
              Icon(Icons.font_download_outlined),
              SizedBox(
                width: 8,
              ),
              Text('タイマーサイズ')
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
            Column(
              children: [
                RadioListTile(
                  title: Column(
                    children: const [
                      Text('大きめ (デフォルト)'),
                    ],
                  ),
                  value: '大きめ',
                  selected: true,
                  groupValue: selectedValue,
                  onChanged: (value) => _onRadioSelected(value),
                ),
                Container(
                    child: const Text(
                  '00:00:00',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Column(
              children: [
                RadioListTile(
                  title: const Text('小さめ'),
                  value: '小さめ',
                  groupValue: selectedValue,
                  onChanged: (value) => _onRadioSelected(value),
                ),
                Container(
                    child: const Text(
                  '00:00:00',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
