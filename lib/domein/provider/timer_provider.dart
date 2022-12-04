import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/provider/timerGroupProvider.dart';
import 'package:timer_group/storage/sqlite.dart';
import 'package:synchronized/synchronized.dart';

final TimersProvider =
    StateNotifierProvider<TimersNotifier, AsyncValue<List<Timer>>>(
  (ref) => TimersNotifier(ref),
);

class TimersNotifier extends StateNotifier<AsyncValue<List<Timer>>> {
  // 初期値
  TimersNotifier(this.ref) : super(const AsyncValue.loading()) {
    _load().ignore();
  }

  final lock = Lock(reentrant: true);
  final Ref ref;

  Future<void> _load() async {
    state = (await AsyncValue.guard(_loadImpl));
  }

  Future<List<Timer>> _loadImpl() async {
    final value = state.asData?.value;
    if (value != null) return value;

    final timers = await ref.read(timerRepositoryProvider).getTimers(0);
    return timers;
  }

  Future<void> addTimer(int groupId, int number) async {
    await ref.read(timerRepositoryProvider).addTimer(groupId, number);
    await updateState(groupId);
  }

  Future<void> removeTimer(int groupId, int number) async {
    await ref.read(timerRepositoryProvider).removeTimer(groupId, number);
    await updateState(groupId);
  }

  Future<void> updateState(int groupId) async {
    final value = await ref.read(timerRepositoryProvider).getTimers(0);
    state = AsyncData(value);
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
    //ref.refresh(timerRepositoryProvider);
  }

  Future<int> getTotal(int id) async => await _db.getTotal(id);
}
