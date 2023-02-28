import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timer_group/views/group_list_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app_splash_page.dart';
import 'configure/theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Themes.defaultTheme,
      darkTheme: Themes.darkTheme,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routes: <String, WidgetBuilder>{
        '/': (_) => AppSplashPage(),
        '/home': (_) => const GroupListPage(),
      },
      supportedLocales: const [
        Locale("ja","JP"),
        //Locale("en"),
      ],
    );
  }
}
