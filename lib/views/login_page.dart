import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/domein/provider/timer_group_provider.dart';
import 'package:timer_group/firebase/firebase_methods.dart';
import 'package:timer_group/views/configure/theme.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Route<LoginPage> route() {
    return MaterialPageRoute<LoginPage>(
      settings: const RouteSettings(name: "/login"),
      builder: (_) => const LoginPage(),
    );
  }

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends ConsumerState<LoginPage> {
  syncDataToFireStore() async {
    final List<TimerGroup> timerGroupList =
        await ref.read(savedTimerGroupProvider.notifier).getTimerGroupList();
    FirebaseMethods().saveAllDataToFireStore(timerGroupList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),
              const Image(
                image: AssetImage('assets/images/app_icon_forground.png'),
                height: 100,
              ),
              const Text(
                'Login to Chirpee !',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'ログイン機能 :',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'タイマーを保存',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '他の端末と同期',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 72,
              ),
              ElevatedButton(
                onPressed: () async {
                  User? user =
                      await FirebaseMethods.signInWithGoogle(context: context);

                  if (user != null) {
                    Fluttertoast.showToast(
                        msg: "ログインしました",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Themes.themeColor,
                        textColor: Colors.white,
                        fontSize: 16.0);

                    syncDataToFireStore(); // ログイン時にデータを同期
                  }

                  if (mounted) Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                    foregroundColor: Themes.grayColor[800],
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    elevation: 8,
                    splashFactory: InkRipple.splashFactory,
                    shadowColor: Themes.themeColor.withOpacity(0.2)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 16, bottom: 16, left: 16, right: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Image(
                        image: AssetImage("assets/images/google_logo.png"),
                        height: 24.0,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        'Sign in with Google',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
