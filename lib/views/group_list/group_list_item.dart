import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/groupOptionsProvider.dart';
import 'package:timer_group/domein/models/timer_group.dart';

import 'group_list_item_tile.dart';

class GroupListItem extends ConsumerStatefulWidget {
  const GroupListItem(this.timerGroup, {Key? key}) : super(key: key);
  final TimerGroup timerGroup;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => DeckListItemState();
}

class DeckListItemState extends ConsumerState<GroupListItem> {
  TimerGroup get timerGroup => widget.timerGroup;

  @override
  Widget build(BuildContext context) {
    final repo = ref.read(timerGroupOptionsRepositoryProvider);
    final id = timerGroup.id;

    return InkWell(
      onTap: () async {
        final options = repo.getOptions(id!);
        final quizOrderMode = ref.read(timerGroupOptionsRepositoryProvider);

        /*
        if (!mounted) return;
        Navigator.of(context).push(
          LearningQuizPage.route(
            detail: detail,
            quizOrderMode: quizOrderMode,
          ),
        );
        */
      },
      child: GroupListItemTile(timerGroup),
    );
  }
}
