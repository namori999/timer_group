import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'package:timer_group/storage/sqlite.dart';

final timerGroupOptionsProvider =
    FutureProvider.autoDispose.family<TimerGroupOptions?, int>((ref, id) async {
  return await SqliteLocalDatabase.timerGroupOptions.get(id);
});

final overTimeProvider =
    FutureProvider.autoDispose.family<bool, int>((ref, groupId) async {
  return ref
      .watch(timerGroupOptionsRepositoryProvider)
      .getOverTimeEnabled(groupId);
});

final timerGroupOptionsRepositoryProvider =
    Provider((ref) => TimerGroupOptionsRepository(ref));

class TimerGroupOptionsRepository {
  TimerGroupOptionsRepository(this.ref);

  static const _optionsdb = SqliteLocalDatabase.timerGroupOptions;
  final Ref ref;

  Future<TimerGroupOptions> getOptions(int id) async =>
      await _optionsdb.get(id);

  Future<bool> getOverTimeEnabled(int id) async {
    final options = await getOptions(id);
    return (options.overTime == 'ON') ? true : false;
  }

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
    return '時分秒';
  }
}
