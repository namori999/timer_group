// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/views/group_add/group_add_page_timer_list_tile.dart';

class AddTimerDialog extends StatelessWidget {
  AddTimerDialog({
    Key? key,
    required this.index,
    required this.title,
    this.overTime,
  }) : super(key: key);

  int index;
  String title;
  bool? overTime;

  GlobalKey<GroupAddPageListTileState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      margin: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close_rounded)),
            ],
          ),
          GroupAddPageTimerListTile(
            index: index,
            title: title,
            overTime: true,
            key: globalKey,
          ),
          const SizedBox(
            height: 16,
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () async {
              Timer? timer = await globalKey.currentState!.addTimer();
              Navigator.pop<Timer>(context, timer);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'タイマーを追加',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
