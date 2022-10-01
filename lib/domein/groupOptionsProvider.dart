import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer_group_info.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/storage/sqlite.dart';

final savedTimerGroupProvider =
    FutureProvider.autoDispose<List<TimerGroup>>((ref) async {
      return SqliteLocalDatabase.timerGroup.getAll();
});

final timerGroupProvider = FutureProvider.autoDispose
    .family<TimerGroup?, String>((ref, title) async {
  return SqliteLocalDatabase.timerGroup.get(title);
});

final timerGroupRepositoryProvider =
    Provider((ref) => timerGroupRepository(ref));

class timerGroupRepository {
  timerGroupRepository(this.ref);

  static const _db = SqliteLocalDatabase.timerGroup;
  final Ref ref;

  Future<TimerGroup> getTimerGroup(String title) async =>
      await _db.get(title);

  Future<int> getId(String title) async =>
      await _db.getId(title);

  Future<void> update(TimerGroupInfo info) async {
    await _db.insert(info);
    ref.refresh(savedTimerGroupProvider);
  }

  Future<int> addTimerGroup(TimerGroupInfo info) async {
    final int = await _db.insert(info);
    ref.refresh(savedTimerGroupProvider);
    return int;
  }

  Future<void> removeTimerGroup(int id) async {
    await _db.delete(id);
    ref.refresh(savedTimerGroupProvider);
  }
}

final savedTimerGroupOptionsProvider =
FutureProvider.autoDispose<List<TimerGroupOptions>>((ref) async {
  return SqliteLocalDatabase.timerGroupOptions.getAll();
});

final timerGroupOptionsProvider = FutureProvider.autoDispose
    .family<TimerGroupOptions?, int>((ref, id) async {
  return await SqliteLocalDatabase.timerGroupOptions.get(id);
});

final timerGroupOptionsRepositoryProvider =
    Provider((ref) => TimerGroupOptionsRepository(ref));

class TimerGroupOptionsRepository {
  TimerGroupOptionsRepository(this.ref);

  static const _db = SqliteLocalDatabase.timerGroupOptions;
  final Ref ref;

  Future<TimerGroupOptions> getOptions(int id) async =>
      await _db.get(id);

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