import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'detail/detail_page_body.dart';

class DetailPage extends ConsumerWidget {
  static Route<DetailPage> route({
    required TimerGroup timerGroup,
    required TimerGroupOptions options,
    required String totalTime,
  }) {
    return MaterialPageRoute<DetailPage>(
      settings: const RouteSettings(name: "/detail"),
      builder: (_) => DetailPage(
        timerGroup: timerGroup,
        options: options,
        totalTime: totalTime,
      ),
    );
  }

  const DetailPage({
    Key? key,
    required this.timerGroup,
    required this.options,
    required this.totalTime,
  }) : super(key: key);

  final TimerGroup timerGroup;
  final TimerGroupOptions options;
  final String totalTime;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'タイマーグループ詳細',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: DetailPageBody(
        timerGroup: timerGroup,
        options: options,
        timers: [],
        totalTime: totalTime,
      ),
    );
  }
}
