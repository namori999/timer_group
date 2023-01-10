import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'group_add_page_timer_list.dart';

class GroupAddPageAddButton extends ConsumerWidget {
  GroupAddPageAddButton({
    required this.title,
    required this.groupId,
    Key? key,
  }) : super(key: key);

  String title;
  int groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
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

            Fluttertoast.showToast(
                msg: '$title を追加しました🕊',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);

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
