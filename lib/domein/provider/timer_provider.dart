import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/provider/timer_group_provider.dart';
import 'package:timer_group/storage/sqlite.dart';

final timerRepositoryProvider = Provider((ref) => timerRepository(ref));

final timersListProvider =
    FutureProvider.family<List<Timer>?, int>((ref, groupId) async {
  return await ref.watch(timerRepositoryProvider).getTimers(groupId);
});

class timerRepository {
  timerRepository(this.ref);

  static const _db = SqliteLocalDatabase.timers;
  final Ref ref;

  Future<List<Timer>> getTimers(int id) async => await _db.getTimers(id);

  Future<Timer> getTimer(int id, int number) async =>
      await _db.getTimer(id, number);

  Future<void> updateTimer(Timer timer) async {
    await _db.update(timer);
    print('timer updated at provider: $timer');
    ref.invalidate(timerRepositoryProvider);
    ref.invalidate(timerGroupRepositoryProvider);
    ref.invalidate(timersListProvider);
  }

  Future<void> addTimers(List<Timer> timers) async {
    for (Timer t in timers) {
      await _db.insert(t);
    }
    ref.invalidate(timerRepositoryProvider);
    ref.invalidate(timerGroupRepositoryProvider);
  }

  Future<void> addTimer(Timer timer) async {
    await _db.insert(timer);
    ref.invalidate(timerRepositoryProvider);
    ref.invalidate(timerGroupRepositoryProvider);
  }

  Future<void> addOverTime(Timer timer) async {
    await _db.insert(timer);
    ref.invalidate(timerRepositoryProvider);
  }

  Future<void> removeTimer(int groupId, int number) async {
    await _db.delete(groupId, number);
    ref.invalidate(timerRepositoryProvider);
    ref.invalidate(timerGroupRepositoryProvider);
  }

  Future<void> removeAllTimers(int groupId) async {
    await _db.deleteAllTimers(groupId);
    ref.invalidate(timerRepositoryProvider);
    ref.invalidate(timerGroupRepositoryProvider);
  }

  Future<int?> getTotal(int id) async => await _db.getTotal(id);
}
