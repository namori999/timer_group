import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


class LocalSharedPreferences {
  const LocalSharedPreferences._(this.preferences);

  static Future<LocalSharedPreferences> instance() async =>
      LocalSharedPreferences._(await SharedPreferences.getInstance());

  final SharedPreferences preferences;

  static const _sortRemainingTimeKey = 'SortRemainingTime';

  bool getSortRemainingTime() =>
      preferences.getBool(_sortRemainingTimeKey) ?? false;

  Future<void> setSortRemainingTime(bool value) async =>
      await preferences.setBool(_sortRemainingTimeKey, value);

  static const _quizOrderModeKey = 'QuizOrderMode';

  /*

  QuizOrderMode getQuizOrderMode() {
    final index = preferences.getInt(_quizOrderModeKey);
    if (index != null && index < QuizOrderMode.values.length) {
      return QuizOrderMode.values[index];
    }
    return QuizOrderMode.shuffle;
  }

  Future<void> setQuizOrderMode(QuizOrderMode mode) async =>
      await preferences.setInt(_quizOrderModeKey, mode.index);

  static const String _quiziumPlayResultKey = 'quiziumPlayResult';

  List<PlayResultParam>? getPlayResults() {
    final json = preferences.getString(_quiziumPlayResultKey);
    if (json == null) return null;

    return PlayResults.fromJson(
      jsonDecode(json) as Map<String, dynamic>,
    ).results;
  }

  Future<void> setPlayResults(List<PlayResultParam> results) async {
    final json = jsonEncode(PlayResults(results: results).toJson());
    await preferences.setString(_quiziumPlayResultKey, json);
  }

  Future<void> clearPlayResults() async {
    await preferences.remove(_quiziumPlayResultKey);
  }

   */
}
