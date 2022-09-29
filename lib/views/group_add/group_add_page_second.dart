import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/groupOptionsProvider.dart';
import 'package:timer_group/domein/timerProvider.dart';
import 'package:timer_group/views/components/outlined_drop_down_button.dart';
import 'package:timer_group/views/configure/theme.dart';
import 'package:timer_group/views/group_add/group_add_page_timer_list_tile.dart';
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
  String overTimeText = 'OFF';
  bool overTimeEnabled = false;
  String totalTime = '';
  int id = 0;

  @override
  initState() {
    super.initState();
      Future(() async {
        id = await ref.watch(timerGroupRepositoryProvider).getId(title);
        totalTime = ref.watch(timerRepositoryProvider).getTotal(id).toString();
      });
    body.add(secondStep());
  }


  Widget secondStep() {

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
              itemList: const ['分秒', '時分'],
              type: "TimeFormat",
              title: title,
            ),
          ],
        ),
        spacer(),
        GroupAddPageTimerList(title: title,),
        spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '合計時間',
            ),
            Padding(
              padding: EdgeInsets.only(right: 32),
              child: Text(
                totalTime,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(130, 40),
                  foregroundColor: Themes.grayColor,
                  side: const BorderSide(
                    color: Themes.grayColor,
                  ),
                ),
                child: Text(
                  overTimeText,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  if (overTimeEnabled) {
                    overTimeEnabled = false;
                    setState(() {
                      overTimeText = 'OFF';
                    });
                  } else {
                    overTimeEnabled = true;
                    setState(() {
                      overTimeText = 'ON';
                      body.add(
                          GroupAddPageTimerListTile(title: title, index: 0,)
                      );
                    });
                  }
                }),
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
