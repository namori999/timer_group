import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timer_group/views/group_list_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'configure/theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Themes.grayColor,
          splashColor: Themes.themeColor,
          fontFamily: 'inter'),
      darkTheme: ThemeData(
          primarySwatch: Themes.grayColor,
          brightness: Brightness.dark,
          splashColor: Themes.themeColor,
          fontFamily: 'inter'),
      home: const GroupListPage(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("en"),
        Locale("ja"),
      ],
    );
  }
}
