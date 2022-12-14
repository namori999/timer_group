import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppDrawer extends ConsumerStatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppDrawerState();
}

class _AppDrawerState extends ConsumerState<AppDrawer> {
  @override
  Widget build(BuildContext context) {
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
  }
}
