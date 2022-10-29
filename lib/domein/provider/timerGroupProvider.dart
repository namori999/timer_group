import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/models/timer_group_info.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/storage/sqlite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synchronized/synchronized.dart';

final savedTimerGroupProvider = StateNotifierProvider<SavedGroupsStateNotifier,
    AsyncValue<List<TimerGroup>>>((ref) {
  return SavedGroupsStateNotifier(ref);
});

final timerGroupProvider =
    FutureProvider.autoDispose.family<TimerGroup?, int>((ref, id) async {
  return SqliteLocalDatabase.timerGroup.get(id);
});

final timerGroupRepositoryProvider =
    Provider((ref) => TimerGroupRepository(ref));

class SavedGroupsStateNotifier
    extends StateNotifier<AsyncValue<List<TimerGroup>>> {
  SavedGroupsStateNotifier(this.ref) : super(const AsyncValue.loading()) {
    _load().ignore();
  }

  final lock = Lock(reentrant: true);
  final Ref ref;

  Future<void> _load() async {
    state = await AsyncValue.guard(_loadImpl);
  }

  Future<List<TimerGroup>> _loadImpl() async {
    final value = state.asData?.value;
    if (value != null) return value;
    return await SqliteLocalDatabase.timerGroup.getAll();
  }

  Future addNewTimerGroup({
    required TimerGroupInfo timerGroupInfo,
  }) async {
    await lock.synchronized(() async {
      final id = await ref
          .read(timerGroupRepositoryProvider)
          .addNewTimerGroup(timerGroupInfo);

      ref.watch(timerGroupOptionsRepositoryProvider).addOption(
          TimerGroupOptions(
              id: id,
              title: timerGroupInfo.title,
              timeFormat: TimeFormat.minuteSecond,
              overTime: 'OFF'));
    });
  }

  Future recoverTimerGroup({
    required TimerGroup timerGroup,
  }) async {
    await lock.synchronized(() {
      ref
          .read(timerGroupRepositoryProvider)
          .recoverTimerGroup(timerGroup, timerGroup.id!);
    });
  }

  Future deleteTimerGroup({
    required TimerGroup timerGroup,
  }) async {
    await lock.synchronized(() async {
      ref.read(timerGroupRepositoryProvider).removeTimerGroup(timerGroup.id!);
      ref
          .watch(timerGroupOptionsRepositoryProvider)
          .removeOption(timerGroup.id!);
      ref.watch(timerRepositoryProvider).removeAllTimers(timerGroup.id!);
    });
  }
}

class TimerGroupRepository {
  TimerGroupRepository(this.ref);

  static const _db = SqliteLocalDatabase.timerGroup;
  static const _optionsDb = SqliteLocalDatabase.timerGroupOptions;
  static const _timersDb = SqliteLocalDatabase.timers;
  final Ref ref;

  Future<TimerGroup?> getTimerGroup(int id) async {
    final groupInfo = await _db.get(id);
    final options = await _optionsDb.get(id);
    final timers = await _timersDb.getTimers(id);
    final totalTime = await _timersDb.getTotal(id);

    return TimerGroup(
      id: id,
      title: groupInfo.title,
      description: groupInfo.description,
      options: options,
      timers: timers,
      totalTime: totalTime,
    );
  }

  Future<int> getId(String title) async => await _db.getId(title);

  Future<void> update(TimerGroupInfo info) async {
    await _db.insert(info);
    ref.refresh(savedTimerGroupProvider);
  }

  Future<int> addNewTimerGroup(TimerGroupInfo info) async {
    final int = await _db.insert(info);
    ref.refresh(savedTimerGroupProvider);
    return int;
  }

  Future<void> recoverTimerGroup(TimerGroup timerGroup, int id) async {
    await _db.insert(TimerGroupInfo(
        title: timerGroup.title, description: timerGroup.description));
    await _optionsDb.insert(timerGroup.options!);
    await _timersDb.insertTimerList(timerGroup.timers!);

    ref.refresh(timerGroupOptionsProvider(id));
    ref.refresh(timerRepositoryProvider);
    ref.refresh(savedTimerGroupProvider);
  }

  Future<void> removeTimerGroup(int id) async {
    await _db.delete(id);
    await _optionsDb.delete(id);
    await _timersDb.delete(id);
    ref.refresh(savedTimerGroupProvider);
  }
}

final savedTimerGroupOptionsProvider =
    FutureProvider.autoDispose<List<TimerGroupOptions>>((ref) async {
  return SqliteLocalDatabase.timerGroupOptions.getAll();
});

final timerGroupOptionsProvider =
    FutureProvider.autoDispose.family<TimerGroupOptions?, int>((ref, id) async {
  return await SqliteLocalDatabase.timerGroupOptions.get(id);
});

final timerGroupOptionsRepositoryProvider =
    Provider((ref) => TimerGroupOptionsRepository(ref));

class TimerGroupOptionsRepository {
  TimerGroupOptionsRepository(this.ref);

  static const _db = SqliteLocalDatabase.timerGroupOptions;
  final Ref ref;

  Future<TimerGroupOptions> getOptions(int id) async => await _db.get(id);

  Future<void> update(TimerGroupOptions timerGroupOptions) async {
    await _db.update(timerGroupOptions);
    ref.refresh(savedTimerGroupProvider);
  }

  Future<void> addOption(TimerGroupOptions timerGroupOptions) async {
    await _db.insert(timerGroupOptions);
    ref.refresh(timerGroupOptionsProvider(timerGroupOptions.id));
  }

  Future<void> removeOption(int id) async {
    await _db.delete(id);
    ref.refresh(timerGroupOptionsProvider(id));
  }
}

String getFormatName(TimerGroupOptions options) {
  if (options.timeFormat == TimeFormat.minuteSecond) {
    return '分秒表示';
  } else {
    return '時分表示';
  }
}

final timerRepositoryProvider = Provider((ref) => timerRepository(ref));

class timerRepository {
  timerRepository(this.ref);

  static const _db = SqliteLocalDatabase.timers;
  final Ref ref;

  Future<List<Timer>> getTimers(int id) async => await _db.getTimers(id);

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

  Future<void> removeAllTimers(int groupId) async {
    await _db.deleteAllTimers(groupId);
    ref.refresh(timerRepositoryProvider);
  }

  Future<String> getTotal(int id) async => await _db.getTotal(id);
}
