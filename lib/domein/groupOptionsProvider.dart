import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/storage/sqlite.dart';

final savedTimerGroupProvider =
    FutureProvider.autoDispose<Map<String, TimerGroup>>((ref) async {
  return SqliteLocalDatabase.timerGroup.getAll();
});

final timerGroupProvider = FutureProvider.autoDispose
    .family<TimerGroup?, String>((ref, timerGroupId) async {
  return SqliteLocalDatabase.timerGroup.get(timerGroupId);
});

final timerGroupRepositoryProvider =
    Provider((ref) => timerGroupRepository(ref));

class timerGroupRepository {
  timerGroupRepository(this.ref);

  static const _db = SqliteLocalDatabase.timerGroup;
  final Ref ref;

  Future<TimerGroup?> getTimerGroup(String timerGroupId) async =>
      await _db.get(timerGroupId);

  Future<void> update(TimerGroup timerGroup) async {
    await _db.insert(timerGroup);
    ref.refresh(timerGroupProvider(timerGroup.title));
    ref.refresh(savedTimerGroupProvider);
  }

  Future<void> addTimerGroup(String title) async {
    await _db.insert(TimerGroup(title: title));
    ref.refresh(timerGroupProvider(title));
    ref.refresh(savedTimerGroupProvider);
  }

  Future<void> removeTimerGroup(String deckId) async {
    await _db.delete(deckId);
    ref.refresh(savedTimerGroupProvider);
  }
}

final savedTimerGroupOptionsProvider = FutureProvider.autoDispose
    .family<TimerGroupOptions?, String>((ref, title) async {
  return await SqliteLocalDatabase.timerGroupOptions.get(title);
});

final timerGroupOptionsRepositoryProvider =
    Provider((ref) => TimerGroupOptionsRepository(ref));

class TimerGroupOptionsRepository {
  TimerGroupOptionsRepository(this.ref);

  static const _db = SqliteLocalDatabase.timerGroupOptions;
  final Ref ref;

  Future<void> getOptions(String title) async =>
      await _db.get(title);

  Future<void> update(TimerGroupOptions timerGroupOptions) async {
    await _db.insert(timerGroupOptions);
    ref.refresh(savedTimerGroupProvider);
  }

  Future<void> addOption(TimerGroupOptions timerGroupOptions) async {
    await _db.insert(timerGroupOptions);
    ref.refresh(savedTimerGroupOptionsProvider(timerGroupOptions.title));
  }

  Future<void> removeOption(String title) async {
    await _db.delete(title);
    ref.refresh(savedTimerGroupOptionsProvider(title));
  }
}
