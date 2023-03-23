import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timer_group/storage/preferances/preferances.dart';

AsyncNotifierProvider<BoolPreferencesNotifier, bool>
    createBoolPreferencesProvider(String key, {bool defaultValue = false}) {
  return AsyncNotifierProvider<BoolPreferencesNotifier, bool>(
    () => BoolPreferencesNotifier(key, defaultValue: defaultValue),
  );
}

class BoolPreferencesNotifier extends AsyncNotifier<bool> {
  BoolPreferencesNotifier(this.prefKey, {this.defaultValue = false});

  final String prefKey;
  final bool defaultValue;

  @override
  FutureOr<bool> build() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(prefKey) ?? defaultValue;
  }

  FutureOr<void> updateData(bool data) async {
    if (state.valueOrNull == data) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(prefKey, data);
    state = AsyncData(data);
  }

  Future<void> removeData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(prefKey);
    state = AsyncData(defaultValue);
  }
}

final isFirstLaunchProvider = createBoolPreferencesProvider(
  LocalSharedPreferences.isFirstLaunchKey,
  defaultValue: false,
);
