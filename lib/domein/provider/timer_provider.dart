import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/provider/timer_group_options_provider.dart';
import 'package:timer_group/domein/provider/timer_group_provider.dart';
import 'package:timer_group/storage/sqlite.dart';

final timerRepositoryProvider = Provider((ref) => timerRepository(ref));

final timersListProvider =
    FutureProvider.family<List<Timer>?, int>((ref, groupId) async {
  final timers = await ref.watch(timerRepositoryProvider).getTimers(groupId);
  print(timers.where((t) => t.isOverTime != 1).toList().length);
  return timers.where((t) => t.isOverTime != 1).toList();
});

final singleTimerProvider =
    FutureProvider.family<Timer, Timer>((ref, timer) async {
  return await ref
      .watch(timerRepositoryProvider)
      .getTimer(timer.groupId, timer.number);
});

class timerRepository {
  timerRepository(this.ref);

  static const _db = SqliteLocalDatabase.timers;
  final Ref ref;

  Future<List<Timer>> getTimers(int id) async => await _db.getTimers(id);

  Future<Timer> getTimer(int id, int number) async =>
      await _db.getTimer(id, number);

  Future<Timer?> getOverTimeTimer(int id) async {
    final timers = await getTimers(id);
    final overTimeTimer = timers.where((t) => t.isOverTime == 1).toList();
    if(overTimeTimer.isNotEmpty) {
      return overTimeTimer.first;
    } else {
      return null;
    }
  }

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
    ref.invalidate(overTimeProvider);
    ref.invalidate(timersListProvider);
  }

  Future<void> removeOverTime(int groupId) async {
    await _db.delete(groupId, 10000);
    ref.invalidate(timerRepositoryProvider);
    ref.invalidate(overTimeProvider);
    ref.invalidate(timersListProvider);
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

  Future<int> getTotal(int id) => _db.getTotal(id);

  Future<int> getMainTimerTotal(int id) async {
    final totalTime = await _db.getTotal(id);
    final overTimeTimer = await getOverTimeTimer(id);
    if (overTimeTimer != null) {
      return totalTime - overTimeTimer.time;
    } else {
      return totalTime;
    }
  }
}
