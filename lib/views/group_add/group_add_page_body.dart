import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/views/configure/theme.dart';
import 'package:timer_group/views/group_add/group_add_page_first.dart';
import 'package:timer_group/views/group_add/group_add_page_second.dart';

class GroupAddPageBody extends ConsumerStatefulWidget {
  GroupAddPageBody({
    Key? key,
    String? defaultEmail,
    String? defaultPassword,
  })  : emailController = TextEditingController(text: defaultEmail),
        passwordController = TextEditingController(text: defaultPassword),
        super(key: key);

  final ScrollController listViewController = ScrollController();
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  ConsumerState createState() => GroupAddPageBodyState();
}

class GroupAddPageBodyState extends ConsumerState<GroupAddPageBody> {
  get emailController => widget.emailController;
  get passwordController => widget.passwordController;

  @override
  WidgetRef get ref => super.ref;

  bool isExpandClicked = false;

  final children = <Widget>[];

  @override
  void initState() {
    super.initState();
    children.add(GroupAddPageFirst());
    children.add(nextStepButton());
  }

  Widget nextStepButton() {
    return IconButton(
      onPressed: () async {
        setState(() {
          children.clear();
          children.add(GroupAddPageFirst());
          children.add(GroupAddPageSecond());
        });
      },
      iconSize: 80,
      icon: const Icon(
        Icons.expand_circle_down_outlined,
        color: Themes.grayColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: children);
  }
}
