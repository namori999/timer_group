import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/provider/timer_group_provider.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/views/group_edit/group_edit_page_body.dart';

class GroupEditPageData extends ConsumerWidget {
  GroupEditPageData({
    required this.id,
    required this.titleController,
    required this.descriptionController,
    Key? key,
  }) : super(key: key);

  int id;
  TextEditingController titleController;
  TextEditingController descriptionController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<TimerGroup?> getTimerGroup() async {
      final timerGroup =
          await ref.read(timerGroupRepositoryProvider).getTimerGroup(id);
      return timerGroup;
    }

    return Padding(
      padding: const EdgeInsets.only(right: 8, left: 8, bottom: 56),
      child: FutureBuilder(
        future: getTimerGroup(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              return const Text('data is null');
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GroupEditPageBody(
                  timerGroup: snapshot.data,
                  titleController: titleController,
                  descriptionController: descriptionController,
                ),
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
