import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/domein/models/timer_group_info.dart';
import 'package:timer_group/domein/provider/timer_group_provider.dart';
import 'package:timer_group/firebase/firebase_methods.dart';
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

  GroupEditPage({
    required this.timerGroup,
    Key? key,
  }) : super(key: key);

  final TimerGroup timerGroup;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<TimerGroup> getTimerGroup(int id) async {
      final timerGroup =
      await ref.watch(timerGroupRepositoryProvider).getTimerGroup(id);
      return timerGroup!;
    }

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.background,
          iconTheme: IconThemeData(
            color: Theme.of(context).primaryColor,
          ),
          elevation: 0,
          actions: [
            MaterialButton(
              onPressed: () async {
                final String title = titleController.text;
                final String description = descriptionController.text;
                print(title);

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

                ref.read(timerGroupRepositoryProvider).update(timerGroup.id!,
                    TimerGroupInfo(title: title, description: description));

                final updatedData = await getTimerGroup(timerGroup.id!);
                FirebaseMethods().saveToFireStore(updatedData);
                Navigator.pop(context);
              },
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
        body: GroupEditPageData(
          id: timerGroup.id!,
          titleController: titleController,
          descriptionController: descriptionController,
        ));
  }
}
