import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/views/components/app_drawer.dart';
import 'package:timer_group/views/group_add_page.dart';
import 'package:timer_group/views/settings_page.dart';

import 'configure/theme.dart';
import 'group_list/group_list_body.dart';

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

  Icon floatingButtonIcon = const Icon(
    Icons.add,
    color: Colors.white,
  );

  Color backGroundColor = Colors.white;

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: backGroundColor,
      leading: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
              icon: const Icon(Icons.person_outlined),
              color: Themes.grayColor.shade700,
              onPressed: () {
                if (!isSheetOpen) {
                  Scaffold.of(context).openDrawer();
                }
              }),
        ),
      ),
      centerTitle: true,
      title: Image.asset(
        'assets/images/app_icon.png',
        fit: BoxFit.contain,
        height: 30,
      ),
      elevation: 10,
      actions: [
        Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
                icon: Icon(Icons.settings_outlined,
                    color: Themes.grayColor.shade700),
                onPressed: () {
                  if (!isSheetOpen) {
                    Navigator.of(context).push(SettingsPage.route());
                  }
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
      drawer: AppDrawer(),
      appBar: appBar(),
      backgroundColor: backGroundColor,
      body: const GroupListBody(),
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton(
            backgroundColor: Colors.black,
            child: floatingButtonIcon,
            onPressed: () => {
              setState(() {
                if (isSheetOpen) {
                  Navigator.of(context).pop();
                } else {
                  floatingButtonIcon = const Icon(
                    Icons.clear,
                    color: Colors.white,
                  );
                  isSheetOpen = true;
                  backGroundColor = Themes.grayColor[700]!;
                  showBottomSheet<void>(
                      context: context,
                      elevation: 20,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30)),
                      ),
                      builder: (context) {
                        return GroupAddPage();
                      }).closed.whenComplete(() {
                    setState(() {
                      floatingButtonIcon = const Icon(
                        Icons.add,
                        color: Colors.white,
                      );
                      isSheetOpen = false;
                      backGroundColor = Colors.white;
                    });
                  });
                }
              }),
            },
          );
        },
      ),
    );
  }
}
