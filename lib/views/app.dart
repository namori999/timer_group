import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timer_group/views/group_list_page.dart';

import 'configure/theme.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Themes.grayColor,
      ),
      darkTheme: ThemeData(
        primarySwatch: Themes.grayColor,
        brightness: Brightness.dark,
      ),
      home: const GroupListPage(),
    );
  }
}
