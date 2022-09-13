import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/views/components/outlined_drop_down_button.dart';
import 'package:timer_group/views/configure/theme.dart';
import 'group_add_page_timer_list.dart';

class GroupAddPageSecond extends ConsumerStatefulWidget {
  GroupAddPageSecond({
    required this.title,
    Key? key,
  }) : super(key: key);

  String title;

  @override
  ConsumerState createState() => GroupAddPageSecondState();
}

class GroupAddPageSecondState extends ConsumerState<GroupAddPageSecond> {
  get title => widget.title;
  var body = <Widget>[];
  List<String> overTimeList = ["OFF", "ON"];

  @override
  void initState() {
    super.initState();
    body.add(secondStep());
  }

  Widget secondStep() {
    List<String> formatList = ["分秒", "時分"];

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "表示単位",
            ),
            OutlinedDropDownButton(
              itemList: formatList,
              type: "TimeFormat",
              timerGroupTitle: title,
            ),
          ],
        ),
        spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "タイマー",
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        const GroupAddPageTimerList(),
        spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              '合計時間',
            ),
            Padding(
              padding: EdgeInsets.only(right: 32),
              child: Text(
                '20分00秒',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "オーバータイム",
            ),
            OutlinedDropDownButton(
              itemList: overTimeList,
              type: "overTime",
              timerGroupTitle: title,
            )
          ],
        ),
        spacer(),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.add_circle_outline,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  'タイマーグループを追加',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
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
    return Column(
      children: body,
    );
  }
}
