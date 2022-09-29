import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timer_group/views/configure/theme.dart';

Widget spacer() {
  return Column(
    children: const [
      SizedBox(height: 16),
      Divider(
        color: Themes.grayColor,
        height: 2,
      ),
      SizedBox(height: 16),
    ],
  );
}
