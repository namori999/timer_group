import 'package:shared_preferences/shared_preferences.dart';

class LocalSharedPreferences {
  const LocalSharedPreferences._(this.preferences);

  static Future<LocalSharedPreferences> instance() async =>
      LocalSharedPreferences._(await SharedPreferences.getInstance());

  final SharedPreferences preferences;

  /// 初めての起動か
  static const isFirstLaunchKey = 'isFirstLaunch';
}
