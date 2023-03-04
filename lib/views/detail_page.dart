import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/provider/timer_group_provider.dart';
import 'package:timer_group/views/configure/theme.dart';
import 'package:timer_group/views/count_down_page.dart';
import 'package:timer_group/views/group_edit_page.dart';
import 'components/ad/AdBanner.dart';
import 'detail/detail_page_data.dart';

class DetailPage extends ConsumerWidget {
  static Route<DetailPage> route({required int id}) {
    return MaterialPageRoute<DetailPage>(
      settings: const RouteSettings(name: "/detail"),
      builder: (_) => DetailPage(
        id: id,
      ),
    );
  }

  const DetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerGroupProvider = ref.watch(timerGroupRepositoryProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                centerTitle: true,
                backgroundColor: Theme.of(context).colorScheme.background,
                iconTheme: IconThemeData(
                  color: Theme.of(context).primaryColor,
                ),
                elevation: 0,
                actions: [
                  IconButton(
                    onPressed: () async {
                      final timerGroup =
                          await timerGroupProvider.getTimerGroup(id);
                      Navigator.push(
                          context,
                          GroupEditPage.route(
                            timerGroup: timerGroup!,
                          ));
                    },
                    icon: const Icon(
                      Icons.edit_outlined,
                    ),
                  )
                ],
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [DetailPageData(id: id)],
                ),
              ),
            ],
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(40),
                      onTap: () async {
                        final timerGroup =
                            await timerGroupProvider.getTimerGroup(id);
                        Navigator.of(context).push(
                          CountDownPage.route(
                            timerGroup: timerGroup!,
                            options: timerGroup.options!,
                            timers: timerGroup.timers!,
                            totalTimeSecond: timerGroup.totalTime!,
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(color: Themes.grayColor, width: 4),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.play_arrow_rounded,
                              color: Theme.of(context).primaryColor,
                              size: 24,
                            ),
                            Text(
                              'スタート',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AdBanner(size: AdSize.largeBanner),
    );
  }
}
