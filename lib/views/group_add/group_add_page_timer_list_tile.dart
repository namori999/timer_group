import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../configure/theme.dart';

class GroupAddPageTimerListTile extends ConsumerWidget {
  const GroupAddPageTimerListTile(
    this.index, {
    Key? key,
  }) : super(key: key);
  final int? index;

  Widget spacer() {
    return Column(
      children: const [
        SizedBox(height: 8),
        Divider(
          color: Themes.grayColor,
          height: 2,
        ),
        SizedBox(height: 8),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // if you need this
        side: BorderSide(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(index.toString()),
              spacer(),
              Row(
                children: [
                  const Icon(Icons.timer_outlined),
                  const Text("タイム"),
                  const Spacer(),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(130, 40),
                      foregroundColor: Themes.grayColor,
                      side: const BorderSide(
                        color: Themes.grayColor,
                      ),
                    ),
                    child: const Text(
                      '分',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => print('Clicked'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.volume_up_outlined),
                  const Text("アラーム音"),
                  const Spacer(),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(130, 40),
                      foregroundColor: Themes.grayColor,
                      side: const BorderSide(
                        color: Themes.grayColor,
                      ),
                    ),
                    child: const Text(
                      '分',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => print('Clicked'),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.music_note_outlined),
                  const Text("BGM"),
                  const Spacer(),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(130, 40),
                      foregroundColor: Themes.grayColor,
                      side: const BorderSide(
                        color: Themes.grayColor,
                      ),
                    ),
                    child: const Text(
                      '分',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => print('Clicked'),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.image_outlined),
                  const Text("背景"),
                  Spacer(),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(130, 40),
                      foregroundColor: Themes.grayColor,
                      side: const BorderSide(
                        color: Themes.grayColor,
                      ),
                    ),
                    child: const Text(
                      '分',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => print('Clicked'),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.notifications_active_outlined),
                  const Text("通知"),
                  Spacer(),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(130, 40),
                      foregroundColor: Themes.grayColor,
                      side: const BorderSide(
                        color: Themes.grayColor,
                      ),
                    ),
                    child: const Text(
                      '分',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => print('Clicked'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
