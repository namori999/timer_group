import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/views/app.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}