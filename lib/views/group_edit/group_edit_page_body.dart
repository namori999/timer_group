import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/domein/provider/timer_group_options_provider.dart';
import 'package:timer_group/domein/provider/timer_provider.dart';
import 'package:timer_group/views/components/outlined_drop_down_button.dart';
import 'package:timer_group/views/components/separoter.dart';
import 'package:timer_group/views/configure/theme.dart';
import 'package:timer_group/views/group_add/group_add_over_time.dart';
import 'package:timer_group/views/group_add/group_add_page_timer_list.dart';

class GroupEditPageBody extends ConsumerStatefulWidget {
  GroupEditPageBody({
    required this.timerGroup,
    required this.titleController,
    required this.descriptionController,
    Key? key,
  }) : super(key: key);

  TimerGroup timerGroup;
  TextEditingController titleController;
  TextEditingController descriptionController;

  @override
  ConsumerState createState() => GroupEditPageBodyState();
}

class GroupEditPageBodyState extends ConsumerState<GroupEditPageBody> {
  TimerGroup get timerGroup => widget.timerGroup;

  TextEditingController get titleController => widget.titleController;

  TextEditingController get descriptionController =>
      widget.descriptionController;
  final ScrollController listViewController = ScrollController();

  String titleText = '';
  String descriptionText = '';
  Timer? overTimeTimer;

  final children = <Widget>[];
  bool isEmpty = false;
  bool onSecondStep = false;

  @override
  void initState() {
    if (timerGroup.options!.overTime! == 'ON') {
      overTimeTimer = timerGroup.timers!.last;
    }
    titleController.text = timerGroup.title;
    if (timerGroup.description != null) {
      descriptionController.text = timerGroup.description!;
    }

    titleController.addListener(() {
      if (titleController.text.isEmpty) {
        isEmpty = true;
      } else {
        isEmpty = false;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final timers = ref.watch(timersListProvider(timerGroup.id!));
    final overTimeEnabled = ref.watch(overTimeProvider(timerGroup.id!));

    return SingleChildScrollView(
      child: SizedBox(
        height: 1200,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 32),
            TextField(
              controller: titleController,
              keyboardType: TextInputType.name,
              maxLength: 20,
              onSubmitted: (String value) => titleText = value,
              onChanged: (String value) => titleText = value,
              textInputAction: TextInputAction.next,
              readOnly: onSecondStep,
              decoration: const InputDecoration(
                label: Text(
                  "タイトル",
                  strutStyle: StrutStyle(height: 1.3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Themes.themeColor, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Themes.grayColor, width: 1.0),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: descriptionController,
              keyboardType: TextInputType.name,
              maxLength: 50,
              onSubmitted: (String value) => descriptionText = value,
              readOnly: onSecondStep,
              decoration: const InputDecoration(
                label: Text(
                  "説明",
                  strutStyle: StrutStyle(height: 1.3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Themes.themeColor, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Themes.grayColor, width: 1.0),
                ),
              ),
            ),
            spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "表示単位",
                ),
                OutlinedDropDownButton(
                  itemList: const ['分秒', '時分秒'],
                  type: "TimeFormat",
                  options: timerGroup.options!,
                ),
              ],
            ),
            spacer(),
            timers.when(
                data: (t) {
                  return GroupAddPageTimerList(
                    timers: t,
                    groupId: timerGroup.id!,
                    overTimeEnabled: overTimeEnabled.when(
                        data: (b) => b,
                        error: (e, s) => false,
                        loading: () => false),
                  );
                },
                error: (e, s) {
                  print({e.toString() + s.toString()});
                  return const Text('sorry, タイマー取得でエラーがでました');
                },
                loading: () =>
                    const Center(child: CircularProgressIndicator())),
            const SizedBox(
              height: 16,
            ),
            spacer(),
            const SizedBox(
              height: 8,
            ),
            overTimeEnabled.when(
                data: (d) => SizedBox(
                      height: 400,
                      child: GroupAddOverTime(
                        groupId: timerGroup.id!,
                        overTimeEnabled: d,
                      ),
                    ),
                error: (e, s) => const SizedBox(),
                loading: () =>
                    const Center(child: CircularProgressIndicator())),
          ],
        ),
      ),
    );
  }
}
