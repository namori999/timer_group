
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/groupOptionsProvider.dart';
import 'package:timer_group/views/group_list/group_list_data.dart';

class GroupListBody extends ConsumerWidget {
  const GroupListBody({Key? key}) : super(key: key);

  @override
  Center build(BuildContext context, WidgetRef ref) {
    final timerGroup = ref.watch(savedTimerGroupProvider);


    Future<void> _failureDialog() async {
      await showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text('取得に失敗しました。'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    }

    return Center(
      child: timerGroup.when(
        loading: () => const CircularProgressIndicator(),
        data: (decks) => GroupListBodyData(decks),
        error: (error, stackTrace) {
          Future(() async => await _failureDialog());
          return const Text("データないよ");
        },
      ),
    );
  }
}
