import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'detail/detail_page_body.dart';


class DetailPage extends ConsumerStatefulWidget {
  static Route<DetailPage> route() {
    return MaterialPageRoute<DetailPage>(
      settings: const RouteSettings(name: "/detail"),
      builder: (_) => const DetailPage(),
    );
  }

  const DetailPage({Key? key}) : super(key: key);

  @override
  ConsumerState<DetailPage> createState() => DetailPageState();
}

class DetailPageState extends ConsumerState<DetailPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'タイマーグループ詳細',
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: DetailPageBody(),
    );
  }
}
