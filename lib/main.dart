import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/views/app.dart';
import 'domein/logic/notififcation.dart';
import 'firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Appを名前付きで初期化
  await Firebase.initializeApp(
      name: 'hoge', options: DefaultFirebaseOptions.currentPlatform);

  //生成されたAppsが紐づくProject IDを出力
  Firebase.apps.forEach((e) {
    print(e.options.projectId);
  });
  await LocalNotification().initializeNotification();
  runApp(const ProviderScope(child: App()));
}
