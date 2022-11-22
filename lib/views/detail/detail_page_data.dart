import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/provider/timerGroupProvider.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/views/detail/detail_page_body.dart';

class DetailPageData extends ConsumerWidget {
  DetailPageData({
    required this.id,
    Key? key,
  }) : super(key: key);

  int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    Future<TimerGroup> getTimerGroup() async {
      final timerGroup = await ref.watch(timerGroupRepositoryProvider)
          .getTimerGroup(id);
      return timerGroup!;
    }

    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, bottom: 56),
      child: FutureBuilder(
              future: getTimerGroup(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data == null) {
                    return const SizedBox();
                  } else {
                    return DetailPageBody(
                      timerGroup: snapshot.data,
                    );
                  }
                } else {
                  return const SizedBox();
                }
              },
            ),
    );
  }
}