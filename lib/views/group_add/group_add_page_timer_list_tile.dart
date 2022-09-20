import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/groupOptionsProvider.dart';
import 'package:timer_group/views/components/dialogs/time_input_dialog.dart';

import '../configure/theme.dart';

class GroupAddPageTimerListTile extends ConsumerStatefulWidget {
  const GroupAddPageTimerListTile({
    this.index,
    required this.title,
    Key? key,
  }) : super(key: key);
  final int? index;
  final String title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      GroupAddPageListTileState();
}

class GroupAddPageListTileState
    extends ConsumerState<GroupAddPageTimerListTile> {
  get index => widget.index;

  get title => widget.title;

  String time = '';
  String alarm = '';
  String bgm = '';

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
  Widget build(BuildContext context) {
    final tgRepo = ref.watch(timerGroupRepositoryProvider);
    final repo = ref.watch(timerGroupOptionsRepositoryProvider);

    //🥺
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
                    child: Row(
                      children: [
                        Text(
                          time,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const Icon(Icons.keyboard_arrow_right_rounded),
                      ],
                    ),
                    onPressed: () async {
                      final id = await tgRepo.getId(title);
                      final options = await repo.getOptions(id);
                      String result = await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) {
                          return TimeInputDialog(
                            timeFormat: options!.timeFormat!,
                          );
                        },
                      );
                      setState(() {
                        time = result;
                      });
                    },
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
                    onPressed: () {},
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
