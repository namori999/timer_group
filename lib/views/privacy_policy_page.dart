import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyPage extends StatelessWidget {
  static Route<PrivacyPolicyPage> route() {
    return PageRouteBuilder<PrivacyPolicyPage>(
      settings: const RouteSettings(name: "/privacy"),
      pageBuilder: (context, animation, secondaryAnimation) {
        return const PrivacyPolicyPage();
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const Offset begin = Offset(1.0, 0.0);
        const Offset end = Offset.zero;
        var curve = Curves.easeInOutQuart;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final Animation<Offset> offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'プライバシーポリシー',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 32), child: SelectionArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '広告について',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              const Text(
                  '本アプリでは、広告配信ツールとしてAdMob(Google Inc.)を使用しており、AdMobがご利用者の情報を自動取得する場合がございます。取得する情報、利用目的、第三者への提供等につきましては、以下の広告配信事業者のアプリケーション・プライバシーポリシーのリンクよりご確認ください。'),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text('Google 広告に関するポリシー', style: TextStyle(fontSize: 12)),
              ),
              TextButton(
                child: const Text(
                    'https://policies.google.com/technologies/ads?hl=ja'),
                onPressed: () {
                  launchUrl(
                    Uri.parse(
                        'https://policies.google.com/technologies/ads?hl=ja'),
                  );
                },
              ),
              const SizedBox(height: 48),
              const Text(
                '利用状況解析ついて',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              const Text(
                  '本アプリでは、今後の開発の参考とするため、アプリの利用状況データを収集するツールとしてFirebase(Google Inc.)を使用しており、Firebaseがご利用者の情報を自動取得する場合がございます。取得する情報、利用目的、第三者への提供等につきましては、以下のGoogleプライバシーポリシーのリンクよりご確認ください。'),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text('Google プライバシーポリシー', style: TextStyle(fontSize: 12)),
              ),
              TextButton(
                child: const Text('https://policies.google.com/privacy?hl=ja'),
                onPressed: () {
                  launchUrl(
                    Uri.parse('https://policies.google.com/privacy?hl=ja'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
