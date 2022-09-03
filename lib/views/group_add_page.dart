import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:timer_group/views/components/group_add_page_body.dart';

class GroupAddPage extends StatelessWidget {
  GroupAddPage({Key key}) : super(key: key);

  final ScrollController listViewController = ScrollController();

  Widget GrabbingWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          width: 100,
          height: 7,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        Container(
          margin: EdgeInsets.all(15).copyWith(top: 0, bottom: 0),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          GrabbingWidget(),
          const Spacer(),
          Text("data"),
          const Spacer(),
        ],
      ),
    );
  }
}
