import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/timerGroupProvider.dart';
import 'package:timer_group/domein/models/timer_group_info.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'package:timer_group/domein/timerProvider.dart';
import 'package:timer_group/views/configure/theme.dart';
import 'package:timer_group/views/group_add/group_add_page_second.dart';

class GroupAddPageBody extends ConsumerStatefulWidget {
  const GroupAddPageBody({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => GroupAddPageBodyState();
}

class GroupAddPageBodyState extends ConsumerState<GroupAddPageBody> {
  bool isExpandClicked = false;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final ScrollController listViewController = ScrollController();

  String titleText = '';
  String descriptionText = '';

  final children = <Widget>[];
  bool isEmpty = false;
  bool onSecondStep = false;

  @override
  void initState() {
    super.initState();
    children.add(
      nextStepButton(),
    );
    titleController.addListener(() {
      if (titleController.text.isEmpty) {
        isEmpty = true;
      } else {
        isEmpty = false;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> cancelAdding() async {
    if (onSecondStep) {
      final repo = ref.watch(timerGroupRepositoryProvider);
      final timerProvider = ref.watch(timerRepositoryProvider);
      final id = await repo.getId(titleText);
      await repo.removeTimerGroup(id);
      await timerProvider.removeAllTimers(id);
    }
  }

  Widget nextStepButton() {
    return IconButton(
      onPressed: () async {
        final title = titleText;
        final description = descriptionText;

        if (title.isEmpty) {
          Fluttertoast.showToast(
              msg: "なにかタイトルをつけてください",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          return;
        }

        onSecondStep = true;
        final provider = ref.watch(timerGroupRepositoryProvider);
        final id = await provider.addNewTimerGroup(
            TimerGroupInfo(title: title, description: description));

        final optionsProvider = ref.watch(timerGroupOptionsRepositoryProvider);
        optionsProvider.addOption(TimerGroupOptions(
            id: id,
            title: title,
            timeFormat: TimeFormat.minuteSecond,
            overTime: 'OFF'));

        setState(() {
          children.clear();
          children.add(GroupAddPageSecond(
            title: title,
          ));
        });
      },
      iconSize: 80,
      icon: const Icon(
        Icons.expand_circle_down_outlined,
        color: Themes.grayColor,
      ),
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextField(
          controller: titleController,
          keyboardType: TextInputType.name,
          maxLength: 10,
          onSubmitted: (String value) => titleText = value,
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
        Column(
          children: children,
        ),
      ],
    );
  }
}
