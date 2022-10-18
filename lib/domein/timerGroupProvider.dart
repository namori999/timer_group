import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer_group_info.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/domein/timerProvider.dart';
import 'package:timer_group/storage/sqlite.dart';

final savedTimerGroupProvider =
    FutureProvider.autoDispose<List<TimerGroup>>((ref) async {
  return SqliteLocalDatabase.timerGroup.getAll();
});

final timerGroupProvider =
    FutureProvider.autoDispose.family<TimerGroup?, String>((ref, title) async {
  return SqliteLocalDatabase.timerGroup.get(title);
});

final timerGroupRepositoryProvider =
    Provider((ref) => timerGroupRepository(ref));

class timerGroupRepository {
  timerGroupRepository(this.ref);

  static const _db = SqliteLocalDatabase.timerGroup;
  static const _optionsDb = SqliteLocalDatabase.timerGroupOptions;
  static const _timersDb = SqliteLocalDatabase.timers;
  final Ref ref;

  Future<TimerGroup> getTimerGroup(String title) async => await _db.get(title);

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

  Future<void> recoverTimerGroup(TimerGroup timerGroup,int id) async {
    final optionsRepo = ref.watch(timerGroupOptionsRepositoryProvider);
    final options = await optionsRepo.getOptions(id);
    final timersRepo = ref.watch(timerRepositoryProvider);
    final timers = await timersRepo.getTimers(id);

    await _db.insert(TimerGroupInfo(
        title: timerGroup.title, description: timerGroup.description));
    await _optionsDb.insert(options);
    await _timersDb.insertTimerList(timers);
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
