import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/storage/sqlite.dart';

final timerRepositoryProvider = Provider((ref) => timerRepository(ref));

class timerRepository {
  timerRepository(this.ref);

  static const _db = SqliteLocalDatabase.timers;
  final Ref ref;

  Future<List<Timer>> getTimers(int id) async => await _db.getTimers(id);

  Future<Timer> getTimer(int id, int number) async =>
      await _db.getTimer(id, number);

  Future<void> update(Timer timer) async {
    await _db.insert(timer);
    //ref.refresh(timerRepositoryProvider);
  }

  Future<void> addTimers(List<Timer> timers) async {
    for (Timer t in timers) {
      await _db.insert(t);
    }
    //ref.refresh(timerRepositoryProvider);
  }

  Future<void> addTimer(int groupId, int number) async {
    await _db.insert(Timer(
        groupId: groupId,
        number: number,
        time: 0,
        soundPath: '',
        bgmPath: '',
        imagePath: '',
        notification: 'ON'));
    ref.invalidate(timerRepositoryProvider);
  }

  Future<void> addOverTime(Timer timer) async {
    await _db.insert(timer);
    ref.invalidate(timerRepositoryProvider);
  }

  Future<void> removeTimer(int id) async {
    await _db.delete(id);
    //ref.refresh(timerRepositoryProvider);
  }

  Future<void> removeAllTimers(int groupId) async {
    await _db.deleteAllTimers(groupId);
    //ref.refresh(timerRepositoryProvider);
  }

  Future<int> getTotal(int id) async => await _db.getTotal(id);
}
