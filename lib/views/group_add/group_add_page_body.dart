import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/provider/timerGroupProvider.dart';
import 'package:timer_group/domein/models/timer_group_info.dart';
import 'package:timer_group/domein/provider/timer_provider.dart';
import 'package:timer_group/views/configure/theme.dart';
import 'package:timer_group/views/group_add/group_add_page_add_button.dart';
import 'package:timer_group/views/group_edit/group_edit_page_body.dart';
import 'package:timer_group/views/group_edit/group_edit_page_data.dart';
import 'package:timer_group/views/group_edit_page.dart';

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
  var groupId = 0;

  @override
  void initState() {
    super.initState();
    titleController.addListener(() {
      if (titleController.text.isEmpty) {
        isEmpty = true;
      } else {
        isEmpty = false;
      }
    });
    children.add(textFields());
    children.add(nextStepButton());
  }

  Future<void> cancelAdding() async {
    if (onSecondStep) {
      final repo = ref.watch(timerGroupRepositoryProvider);
      final timerProvider = ref.watch(timerRepositoryProvider);
      await repo.removeTimerGroup(groupId);
      await timerProvider.removeAllTimers(groupId);
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
        final provider = ref.watch(savedTimerGroupProvider.notifier);
        final groupId = await provider.addNewGroup(
          TimerGroupInfo(title: title, description: description),
        );
        final timerGroup = await ref
            .watch(timerGroupRepositoryProvider)
            .getTimerGroup(groupId);

        children.clear();
        children.add(
          GroupEditPageData(
              id: timerGroup!.id!,
              titleController: titleController,
              descriptionController: descriptionController),
        );
        children.add(GroupAddPageAddButton(title: title, groupId: groupId));

        setState(() {});
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

  Widget textFields() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
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
          onChanged: (String value) => descriptionText = value,
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: children,
    );
  }
}
