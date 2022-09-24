
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/views/group_add/group_add_page_timer_list_tile.dart';

class AddTimerDialog extends StatelessWidget {
  AddTimerDialog({Key? key, required this.index, required this.title})
      : super(key: key);

  int index;
  String title;

  GlobalKey<GroupAddPageListTileState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          GroupAddPageTimerListTile(index: index, title: title, key: globalKey,),
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
              Timer timer = await globalKey.currentState!.addTimer();
              Navigator.pop<Timer>(context, timer);
            },
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
        ],
      ),
    );
  }
}
