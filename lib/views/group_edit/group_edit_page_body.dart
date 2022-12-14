import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/models/timer_group.dart';
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

  Future<List<Timer>> getTimers() async {
    final timerProvider = ref.watch(timerRepositoryProvider);
    final timers = await timerProvider.getTimers(timerGroup.id!);
    return timers;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SingleChildScrollView(
        child: SizedBox(
          height: 1200,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 32),
              TextField(
                controller: titleController,
                keyboardType: TextInputType.name,
                maxLength: 10,
                onSubmitted: (String value) => titleText = value,
                onChanged: (String value) => titleText = value,
                textInputAction: TextInputAction.next,
                readOnly: onSecondStep,
                decoration: const InputDecoration(
                  label: Text(
                    "????????????",
                    strutStyle: StrutStyle(height: 1.3),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Themes.themeColor, width: 1.0),
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
                    "??????",
                    strutStyle: StrutStyle(height: 1.3),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Themes.themeColor, width: 1.0),
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
                    "????????????",
                  ),
                  OutlinedDropDownButton(
                    itemList: const ['??????', '??????'],
                    type: "TimeFormat",
                    title: timerGroup.title,
                  ),
                ],
              ),
              spacer(),
              FutureBuilder(
                future: getTimers(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<Timer>> timers) {
                  if (timers.hasData) {
                    return GroupAddPageTimerList(
                        timers: timers.data, groupId: timerGroup.id!);
                  } else {
                    return Text("??????????????????????????????");
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),
              spacer(),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 400,
                child: GroupAddOverTime(
                  title: timerGroup.title,
                  overTimeTimer: overTimeTimer,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
