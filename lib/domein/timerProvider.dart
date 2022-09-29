import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/storage/sqlite.dart';

final timerRepositoryProvider =
    Provider((ref) => timerRepository(ref));

class timerRepository {
  timerRepository(this.ref);

  static const _db = SqliteLocalDatabase.timers;
  final Ref ref;

  Future<List<Timer>> getTimers(int id) async =>
      await _db.getTimers(id);

  Future<void> update(Timer timer) async {
    await _db.insert(timer);
    ref.refresh(timerRepositoryProvider);
  }

  Future<void> addTimer(Timer timer) async {
    await _db.insert(timer);
    ref.refresh(timerRepositoryProvider);
  }

  Future<void> removeTimer(int id) async {
    await _db.delete(id);
    ref.refresh(timerRepositoryProvider);
  }

  Future<String> getTotal(int id) async =>
    await _db.getTotal(id);
}