import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/groupOptionsProvider.dart';
import 'package:timer_group/domein/models/timer_group_info.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'package:timer_group/views/configure/theme.dart';
import 'package:timer_group/views/group_add/group_add_page_second.dart';

class GroupAddPageBody extends ConsumerStatefulWidget {
  GroupAddPageBody({
    String? defaultEmail,
    String? defaultPassword,
    Key? key,
  })  : titleController = TextEditingController(text: defaultEmail),
        descriptionController = TextEditingController(text: defaultPassword),
        super(key: key);

  final TextEditingController titleController;
  final TextEditingController descriptionController;

  final ScrollController listViewController = ScrollController();

  @override
  ConsumerState createState() => GroupAddPageBodyState();
}

class GroupAddPageBodyState extends ConsumerState<GroupAddPageBody> {
  bool isExpandClicked = false;

  TextEditingController get titleController => widget.titleController;

  TextEditingController get descriptionController =>
      widget.descriptionController;

  final children = <Widget>[];
  bool isEmpty = false;

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

  Widget nextStepButton() {
    return IconButton(
      onPressed: () async {
        final title = titleController.text;
        final description = descriptionController.text;
        if (!isEmpty) {
          final provider = ref.watch(timerGroupRepositoryProvider);
          final id = await provider.addTimerGroup(
              TimerGroupInfo(
              title: title, description: description)
          );

          final optionsProvider =
              ref.watch(timerGroupOptionsRepositoryProvider);
          optionsProvider.addOption(
              TimerGroupOptions(
                  id: id, title: title, timeFormat: null, overTime: null)
          );

          setState(() {
            children.clear();
            children.add(GroupAddPageSecond(
              title: title,
            ));
          });
        }
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
          keyboardType: TextInputType.text,
          maxLength: 10,
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
          keyboardType: TextInputType.text,
          maxLength: 50,
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
