import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'package:timer_group/domein/provider/timerGroupOptionsProvider.dart';
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
      final timerGroup =
          await ref.watch(timerGroupRepositoryProvider).getTimerGroup(id);
      return timerGroup!;
    }

    Future<TimerGroupOptions> getOptions(int id) async {
      final optionsProvider = ref.watch(timerGroupOptionsRepositoryProvider);
      final options = await optionsProvider.getOptions(id);

      return options;
    }

    return FutureBuilder(
      future: getTimerGroup(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> timerGroup) {
        if (timerGroup.connectionState == ConnectionState.done) {
          if (timerGroup.data == null) {
            return const SizedBox();
          } else {
            return FutureBuilder(
                future: getOptions(timerGroup.data.id),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> options) {
                  if (options.connectionState == ConnectionState.done) {
                    return DetailPageBody(
                      timerGroup: timerGroup.data,
                      options: options.data,
                    );
                  } else {
                    return const SizedBox();
                  }
                });
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
