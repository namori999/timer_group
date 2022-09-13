import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timer_group/views/group_add/group_add_page_body.dart';

class GroupAddPage extends StatelessWidget {
  const GroupAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          const Text(
            "タイマーグループを追加",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          GroupAddPageBody(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
