import 'package:flutter/material.dart';
import 'package:timer_group/views/components/app_drawer.dart';
import 'package:timer_group/views/group_add_page.dart';
import 'package:timer_group/views/settings_page.dart';

import 'configure/theme.dart';

class GroupListPage extends StatefulWidget {
  static Route<GroupListPage> route() {
    return MaterialPageRoute<GroupListPage>(
      settings: const RouteSettings(name: "/group"),
      builder: (_) => const GroupListPage(),
    );
  }

  const GroupListPage({Key key}) : super(key: key);

  @override
  State<GroupListPage> createState() => _GroupListPageState();
}

class _GroupListPageState extends State<GroupListPage> {
  var isDrawerOpen = false;

  Icon floatingButtonIcon = const Icon(
    Icons.add,
    color: Colors.white,
  );

  Color backGroundColor = Colors.white;

  Widget appBar() {
      return  AppBar(
        backgroundColor: backGroundColor,
        leading: Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.only(left: 10),
            child: IconButton(
                icon: const Icon(Icons.person_outlined),
                color: Themes.grayColor.shade700,
                onPressed: () {
                  if (!isDrawerOpen) {
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
                    if (!isDrawerOpen) {
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
      drawer: const AppDrawer(),
      appBar: appBar(),
      backgroundColor: backGroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "main",
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton(
            backgroundColor: Colors.black,
            child: floatingButtonIcon,
            onPressed: () => {
              setState(() {
                if (isDrawerOpen) {
                  floatingButtonIcon = const Icon(
                    Icons.add,
                    color: Colors.white,
                  );
                  isDrawerOpen = false;
                  backGroundColor = Colors.white;
                  Navigator.of(context).pop();
                } else {
                  floatingButtonIcon = const Icon(
                    Icons.clear,
                    color: Colors.white,
                  );
                  isDrawerOpen = true;
                  backGroundColor = Themes.grayColor[700];
                  showBottomSheet(
                    context: context,
                    elevation: 20,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30)),
                    ),
                    builder: (BuildContext context) {
                      return GroupAddPage();
                    },
                  );
                }
              }),
            },
          );
        },
      ),
    );
  }
}
