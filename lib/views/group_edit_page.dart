import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'group_edit/group_edit_page_data.dart';

class GroupEditPage extends ConsumerWidget {
  static Route<GroupEditPage> route({
    required timerGroup,
  }) {
    return MaterialPageRoute<GroupEditPage>(
      settings: const RouteSettings(name: "/edit"),
      builder: (_) => GroupEditPage(
        timerGroup: timerGroup,
      ),
    );
  }

  const GroupEditPage({
    required this.timerGroup,
    Key? key,
  }) : super(key: key);

  final TimerGroup timerGroup;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        elevation: 0,
        actions: [
          MaterialButton(
            onPressed: () {},
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Text(
                '完了',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: GroupEditPageData(id: timerGroup.id!,)
    );
  }
}
