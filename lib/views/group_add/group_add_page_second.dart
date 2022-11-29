import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/logic/time_converter.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/provider/timerGroupOptionsProvider.dart';
import 'package:timer_group/domein/provider/timerGroupProvider.dart';
import 'package:timer_group/views/components/outlined_drop_down_button.dart';
import 'package:timer_group/views/components/separoter.dart';
import 'package:timer_group/views/group_add/group_add_over_time.dart';
import 'package:timer_group/views/group_add/group_add_page_timer_list_tile.dart';
import 'group_add_page_timer_list.dart';

class GroupAddPageSecond extends ConsumerStatefulWidget {
  GroupAddPageSecond({
    required this.title,
    required this.groupId,
    Key? key,
  }) : super(key: key);

  String title;
  int groupId;

  @override
  ConsumerState createState() => GroupAddPageSecondState();
}

class GroupAddPageSecondState extends ConsumerState<GroupAddPageSecond> {
  get title => widget.title;
  get groupId => widget.groupId;
  var body = <Widget>[];
  String overTimeText = 'OFF';
  String totalTime = '';
  var timer;
  GlobalKey<GroupAddPageListTileState> globalKey = GlobalKey();

  @override
  initState() {
    super.initState();
  }

  Future<void> addOverTime() async {
    final optionsProvider = ref.read(timerGroupOptionsRepositoryProvider);
    final option = await optionsProvider.getOptions(groupId);
    if (option.overTime == 'ON') {
      final provider = ref.watch(timerRepositoryProvider);
      await provider.addTimer(Timer(
          groupId: groupId,
          number: 0,
          time: timeToSecond(GroupAddPageListTileState.time),
          soundPath: GroupAddPageListTileState.alarmTitle,
          bgmPath: GroupAddPageListTileState.bgmTitle,
          imagePath: GroupAddPageListTileState.imageTitle,
          notification: GroupAddPageListTileState.notification));
    }
  }



  @override
  Widget build(BuildContext context) {
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
        GroupAddPageTimerList(
          title: title,
        ),
        spacer(),
        GroupAddOverTime(title: title),
        spacer(),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () async {
            if (GroupAddPageTimerListState.index == 0) {
              Fluttertoast.showToast(
                  msg: 'タイマーを１つ以上追加してください',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
              return;
            }

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
}
