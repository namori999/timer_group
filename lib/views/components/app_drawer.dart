import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:timer_group/firebase/firebase_methods.dart';
import 'package:timer_group/views/login_page.dart';
import 'package:timer_group/views/privacy_policy_page.dart';

class AppDrawer extends ConsumerStatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppDrawerState();
}

class _AppDrawerState extends ConsumerState<AppDrawer> {
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    if (FirebaseMethods().getUser() != null) {
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
                  isLogin
                      ? ListTile(
                          leading: const Icon(Icons.login_outlined),
                          title: const Text("ログアウト"),
                          onTap: () async {
                            setState(() {
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
                            await FirebaseMethods.signOut(context: context);
                          },
                        )
                      : ListTile(
                          leading: const Icon(Icons.login_outlined),
                          title: const Text("ログイン"),
                          onTap: () async {
                            await Navigator.of(context).push(LoginPage.route());
                            setState(() {
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

    /*
    //final user = ref.watch(userProvider);
    final user = null;
    if (user == null) {
      // 未ログイン
      return ClipRRect(
        borderRadius:
            const BorderRadius.horizontal(right: Radius.circular(160)),
        child: SizedBox(
          width: 200,
          child: Drawer(
            child: ListView(
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                  ),
                  child: null,
                ),
                ListTile(
                  leading: const Icon(Icons.login_outlined),
                  title: const Text("ログイン"),
                  onTap: () async {},
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Drawer(
      child: ListView(
        // ログイン済み
        children: [
          //const UserDrawerHeader(),
          ListTile(
            leading: const Icon(Icons.app_shortcut),
            title: const Text("アプリ情報"),
            onTap: () {},
          ),
          const Divider(
            height: 20,
            thickness: 1,
            indent: 20,
            endIndent: 20,
            color: Colors.black38,
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("ログアウト"),
            onTap: () async {},
          ),
        ],
      ),
    );

     */
  }
}
