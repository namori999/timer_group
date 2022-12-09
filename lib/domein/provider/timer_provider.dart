import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/provider/timerGroupProvider.dart';
import 'package:timer_group/storage/sqlite.dart';

final TimersProvider =
    StateNotifierProvider<TimersNotifier, List<Timer>>((ref) {
  return TimersNotifier(ref);
});

class TimersNotifier extends StateNotifier<List<Timer>> {
  TimersNotifier(this.ref) : super([]);

  Ref ref;

  Future<void> addTimer(Timer timer) async {
    await ref.read(timerRepositoryProvider).addTimer(timer);
    await updateState(timer.groupId);
  }

  Future<void> removeTimer(int groupId, int number) async {
    await ref.read(timerRepositoryProvider).removeTimer(groupId, number);
    await updateState(groupId);
  }

  Future<void> updateTimer(Timer timer) async {
    await ref.read(timerRepositoryProvider).update(timer);
    await updateState(timer.groupId);
  }

  Future<void> updateState(int groupId) async {
    final value = await ref.read(timerRepositoryProvider).getTimers(groupId);
    ref.invalidate(timerRepositoryProvider);
    state = value;
  }
}

final timerRepositoryProvider = Provider((ref) => timerRepository(ref));

class timerRepository {
  timerRepository(this.ref);

  static const _db = SqliteLocalDatabase.timers;
  final Ref ref;

  Future<List<Timer>> getTimers(int id) async => await _db.getTimers(id);

  Future<Timer> getTimer(int id, int number) async =>
      await _db.getTimer(id, number);

  Future<void> update(Timer timer) async {
    await _db.update(timer);
    print('timer updated at provider: $timer');
    ref.invalidate(timerRepositoryProvider);
    ref.invalidate(timerGroupRepositoryProvider);
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
  }

  Future<void> removeAllTimers(int groupId) async {
    await _db.deleteAllTimers(groupId);
    ref.invalidate(timerRepositoryProvider);
    ref.invalidate(timerGroupRepositoryProvider);
  }

  Future<int?> getTotal(int id) async => await _db.getTotal(id);
}
