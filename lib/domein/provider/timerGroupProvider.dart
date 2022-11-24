import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/models/timer_group_info.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/storage/sqlite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final timerGroupRepositoryProvider =
    Provider((ref) => TimerGroupRepository(ref));

class TimerGroupRepository {
  TimerGroupRepository(this.ref);

  static const _db = SqliteLocalDatabase.timerGroup;
  static const _optionsDb = SqliteLocalDatabase.timerGroupOptions;
  static const _timersDb = SqliteLocalDatabase.timers;
  final Ref ref;

  Future<List<TimerGroup>> getAll() async {
    return await _db.getAll();
  }

  Future<TimerGroup?> getTimerGroup(int id) async {
    final groupInfo = await _db.get(id);
    final options =
        await ref.watch(timerGroupOptionsRepositoryProvider).getOptions(id);
    final timers = await ref.watch(timerRepositoryProvider).getTimers(id);
    final totalTime = await ref.watch(timerRepositoryProvider).getTotal(id);

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
    //ref.refresh(savedTimerGroupProvider);
  }

  Future<int> addNewTimerGroup(TimerGroupInfo info) async {
    final int = await _db.insert(info);
    await _optionsDb.insert(TimerGroupOptions(id: int, title: info.title));
    return int;
  }

  Future<void> recoverTimerGroup({required TimerGroup timerGroup}) async {
    await _db.insert(TimerGroupInfo(
        title: timerGroup.title, description: timerGroup.description));
    await _optionsDb.insert(timerGroup.options!);
    for (Timer t in timerGroup.timers!) {
      await _timersDb.insert(t);
    }
  }

  Future<void> removeTimerGroup(int id) async {
    await _db.delete(id);
    await _optionsDb.delete(id);
    await _timersDb.delete(id);
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

  static const _db = SqliteLocalDatabase.timerGroup;
  static const _optionsdb = SqliteLocalDatabase.timerGroupOptions;
  final Ref ref;

  Future<TimerGroupOptions> getOptions(int id) async =>
      await _optionsdb.get(id);

  Future<void> update(TimerGroupOptions timerGroupOptions) async {
    await _optionsdb.update(timerGroupOptions);
  }

  Future<void> addOption(TimerGroupOptions timerGroupOptions) async {
    await _optionsdb.insert(timerGroupOptions);
    //ref.refresh(timerGroupOptionsProvider(timerGroupOptions.id));
  }

  Future<void> removeOption(int id) async {
    await _optionsdb.delete(id);
    //ref.refresh(timerGroupOptionsProvider(id));
  }
}

String getFormatName(TimerGroupOptions options) {
  if (options.timeFormat == TimeFormat.minuteSecond) {
    return '分秒';
  } else {
    return '時分';
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
    //ref.refresh(timerRepositoryProvider);
  }

  Future<void> addTimers(List<Timer> timers) async {
    for (Timer t in timers) {
      await _db.insert(t);
    }
    //ref.refresh(timerRepositoryProvider);
  }

  Future<void> addTimer(Timer timer) async {
    await _db.insert(timer);
    //ref.refresh(timerRepositoryProvider);
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
