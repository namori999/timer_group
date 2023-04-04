import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:timer_group/firebase/firebase_methods.dart';
import 'package:timer_group/views/login_page.dart';
import 'package:timer_group/views/privacy_policy_page.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool isLogin = false;
  User? user;

  @override
  void initState() {
    super.initState();
    if (FirebaseMethods.getUser() != null) {
      user = FirebaseMethods.getUser();
      isLogin = true;
    }
    print(isLogin);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.horizontal(right: Radius.circular(160)),
      child: SizedBox(
        width: 200,
        child: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  if (user != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        (user!.photoURL != null)
                            ? Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.network(user!.photoURL!)),
                                ),
                              )
                            : const Icon(Icons.account_circle_outlined),
                        ListTile(
                          title: Text(user!.displayName!),
                          subtitle: Text(
                            user!.email!,
                            style: const TextStyle(fontSize: 12),
                          ),
                          onTap: () async {},
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 8,
                  ),
                  isLogin
                      ? ListTile(
                          leading: const Icon(Icons.logout_outlined),
                          title: const Text("ログアウト"),
                          onTap: () async {
                            await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("ログアウトしますか？"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("キャンセル"),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      setState(() {
                                        user = null;
                                        isLogin = false;
                                      });
                                      Fluttertoast.showToast(
                                          msg: "ログアウトしました",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.grey,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      await FirebaseMethods.signOut(
                                          context: context);
                                      if (mounted) Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "ログアウト",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : ListTile(
                          leading: const Icon(Icons.login_outlined),
                          title: const Text("ログイン"),
                          onTap: () async {
                            await Navigator.of(context).push(LoginPage.route());
                            setState(() {
                              user = FirebaseMethods.getUser();
                              isLogin = true;
                            });
                          },
                        ),
                  const SizedBox(
                    height: 100,
                  ),
                  ListTile(
                    leading: const Icon(Icons.info_outline_rounded),
                    title: const Text("アプリ情報"),
                    onTap: () async {
                      showLicensePage(
                        context: context,
                        applicationName: 'Chirpiee',
                        applicationVersion: '1.0.1',
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.info_outline_rounded),
                    title: const Text("プライバシーポリシー"),
                    onTap: () async {
                      Navigator.of(context).push(PrivacyPolicyPage.route());
                    },
                  ),
                ],
              ),
              const ListTile(
                title: Text('Copyright \n ©︎ 2023 giorno,Inc'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
