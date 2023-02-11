import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/provider/timer_group_provider.dart';
import 'package:timer_group/views/components/app_drawer.dart';
import 'package:timer_group/views/group_add/group_add_page_body.dart';
import 'package:timer_group/views/group_add_page.dart';
import 'package:timer_group/views/settings_page.dart';

import 'configure/theme.dart';
import 'group_list/group_list_data.dart';

class GroupListPage extends ConsumerStatefulWidget {
  static Route<GroupListPage> route() {
    return MaterialPageRoute<GroupListPage>(
      settings: const RouteSettings(name: "/group"),
      builder: (_) => const GroupListPage(),
    );
  }

  const GroupListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<GroupListPage> createState() => _GroupListPageState();
}

class _GroupListPageState extends ConsumerState<GroupListPage> {
  var isSheetOpen = false;
  Color backGroundColor = Colors.white;
  late Icon floatingButtonIcon = Icon(
    Icons.add,
    color: Theme.of(context).primaryColor,
  );

  void showCancelAlert() {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('編集中のグループを削除します'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('キャンセル'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoDialogAction(
                child: const Text(
                  '削除',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () async {
                  await canselAdding();
                  Navigator.pop<bool>(context);
                  Navigator.pop(this.context);
                }),
          ],
        );
      },
    );
  }

  Future<void> canselAdding() async {
    if (GroupAddPageBodyState.onSecondStep) {
      final id =
          await ref.read(savedTimerGroupProvider.notifier).getEditingId();
      final repo = ref.watch(timerGroupRepositoryProvider);
      if (id != null) await repo.removeTimerGroup(id);
    }
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor:
          (isSheetOpen && Theme.of(context).brightness == Brightness.light)
              ? Colors.grey
              : Theme.of(context).colorScheme.background,
      leading: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
              splashColor: isSheetOpen ? Colors.transparent : Themes.themeColor,
              highlightColor:
                  isSheetOpen ? Colors.transparent : Themes.themeColor,
              icon: const Icon(Icons.person_outlined),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                isSheetOpen ? null : Scaffold.of(context).openDrawer();
              }),
        ),
      ),
      centerTitle: true,
      title: Image.asset(
        'assets/images/app_icon_forground.png',
        fit: BoxFit.contain,
        height: 30,
      ),
      elevation: 10,
      actions: [
        Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
                splashColor:
                    isSheetOpen ? Colors.transparent : Themes.themeColor,
                highlightColor:
                    isSheetOpen ? Colors.transparent : Themes.themeColor,
                icon: Icon(Icons.settings_outlined,
                    color: Theme.of(context).primaryColor),
                onPressed: () {
                  isSheetOpen
                      ? null
                      : Navigator.of(context).push(SettingsPage.route());
                })),
      ],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: appBar(),
      backgroundColor:
          (isSheetOpen && Theme.of(context).brightness == Brightness.light)
              ? Colors.grey
              : Theme.of(context).colorScheme.background,
      body: GroupListBodyData(),
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton(
              backgroundColor:
                  Theme.of(context).cardColor.withOpacity(0.6),
              elevation: 0,
              shape: StadiumBorder(
                  side: BorderSide(
                      color: Theme.of(context).primaryColor, width: 4)),
              child: floatingButtonIcon,
              onPressed: () {
                if (isSheetOpen) {
                  showCancelAlert();
                } else {
                  setState(() {
                    floatingButtonIcon = Icon(
                      Icons.clear,
                      color: Theme.of(context).primaryColor,
                    );
                    isSheetOpen = true;
                    backGroundColor = Themes.grayColor[700]!;
                    showBottomSheet(
                        context: context,
                        backgroundColor: Theme.of(context).cardColor,
                        elevation: 20,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(30)),
                        ),
                        builder: (context) {
                          return const GroupAddPage();
                        }).closed.whenComplete(() {
                      setState(() {
                        floatingButtonIcon = Icon(
                          Icons.add,
                          color: Theme.of(context).iconTheme.color,
                        );
                        isSheetOpen = false;
                        backGroundColor = Colors.white;
                      });
                    });
                  });
                }
              });
        },
      ),
    );
  }
}
