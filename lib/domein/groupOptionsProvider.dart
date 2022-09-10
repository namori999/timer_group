import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'package:timer_group/storage/sqlite.dart';

final timerGroupOptionsProvider =
    FutureProvider.autoDispose<Map<int, TimerGroupOptions>>((ref) async {
  return await SqliteLocalDatabase.timerGroupOptions.getAll();
});

final timerGroupOptionsRepositoryProvider =
    Provider((ref) => TimerGroupOptionsRepository(ref));

class TimerGroupOptionsRepository {
  TimerGroupOptionsRepository(this.ref);

  static const _db = SqliteLocalDatabase.timerGroupOptions;
  final Ref ref;

  Future<TimerGroupOptions?> getOptions(int timerGroupId) async =>
      await _db.get(timerGroupId.toString());

  Future<void> update(TimerGroupOptions timerGroupOptions) async {
    await _db.insert(timerGroupOptions);
    ref.refresh(timerGroupOptionsProvider);
  }

  Future<void> addOption(TimerGroupOptions timerGroupOptions) async {
    await _db.insert(timerGroupOptions);
    ref.refresh(timerGroupOptionsProvider);
  }

  Future<void> removeOption(String timerGroupId) async {
    await _db.delete(timerGroupId);
    ref.refresh(timerGroupOptionsProvider);
  }
}
