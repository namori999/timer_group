import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/models/timer_group_info.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/domein/provider/timer_group_options_provider.dart';
import 'package:timer_group/domein/provider/timer_provider.dart';
import 'package:timer_group/storage/sqlite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synchronized/synchronized.dart';

final timerGroupRepositoryProvider =
    Provider((ref) => TimerGroupRepository(ref));

class TimerGroupRepository {
  TimerGroupRepository(this.ref);

  static const _db = SqliteLocalDatabase.timerGroup;
  static const _optionsDb = SqliteLocalDatabase.timerGroupOptions;
  static const _timersDb = SqliteLocalDatabase.timers;
  final Ref ref;
  late final optionsProvider = ref.watch(timerGroupOptionsRepositoryProvider);

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

  Future<void> update(int id, TimerGroupInfo info) async {
    await _db.update(id, info);
    ref.invalidate(timerGroupRepositoryProvider);
  }

  Future<int> addNewTimerGroup(TimerGroupInfo info) async {
    final int = await _db.insert(info);
    await _optionsDb.insert(TimerGroupOptions(
        id: int, timeFormat: TimeFormat.minuteSecond, overTime: 'OFF'));
    return int;
  }

  Future<void> addTimerGroupList(List<TimerGroup> timerGroups) async {
    for (TimerGroup tg in timerGroups) {
      await _db.insertWhereId(
          TimerGroupInfo(title: tg.title, description: tg.description), tg.id!);
      await _optionsDb.insert(TimerGroupOptions(
          id: tg.id!, timeFormat: TimeFormat.minuteSecond, overTime: 'OFF'));
      if (tg.timers != null && tg.timers!.isNotEmpty) {
        await _timersDb.insertTimerList(tg.timers!);
      }
    }
    ref.invalidate(savedTimerGroupProvider);
    ref.invalidate(timerGroupRepositoryProvider);
  }

  Future<void> recoverTimerGroup(TimerGroup timerGroup) async {
    final newId = await _db.insert(TimerGroupInfo(
        title: timerGroup.title, description: timerGroup.description));
    await _optionsDb.insert(
      TimerGroupOptions(
        id: newId,
        timeFormat: timerGroup.options!.timeFormat,
        overTime: timerGroup.options!.overTime,
      ),
    );
    for (Timer t in timerGroup.timers!) {
      await _timersDb.insert(t);
    }
  }

  Future<void> removeTimerGroup(int id) async {
    await _db.delete(id);
    await _optionsDb.delete(id);
    await _timersDb.deleteAllTimers(id);
    ref.invalidate(timerGroupRepositoryProvider);
    ref.invalidate(timerGroupOptionsRepositoryProvider);
    ref.invalidate(timerRepositoryProvider);
  }
}

final savedTimerGroupProvider = StateNotifierProvider<savedTimerGroupNotifier,
    AsyncValue<List<TimerGroup>>>(
  (ref) => savedTimerGroupNotifier(ref),
);

class savedTimerGroupNotifier
    extends StateNotifier<AsyncValue<List<TimerGroup>>> {
  // 初期値
  savedTimerGroupNotifier(this.ref) : super(const AsyncValue.loading()) {
    _load().ignore();
  }

  final lock = Lock(reentrant: true);
  final Ref ref;

  Future<void> _load() async {
    state = (await AsyncValue.guard(loadImpl));
  }

  Future<List<TimerGroup>> loadImpl() async {
    final List<TimerGroup> timerGroups = [];
    final timerGroupInfo =
        await ref.read(timerGroupRepositoryProvider).getAll();
    for (TimerGroup i in timerGroupInfo) {
      final tg =
          await ref.read(timerGroupRepositoryProvider).getTimerGroup(i.id!);

      timerGroups.add(
        TimerGroup(
          id: i.id,
          title: i.title,
          description: i.description,
          options: tg!.options,
          timers: tg.timers,
          totalTime: tg.totalTime,
        ),
      );
    }
    return timerGroups;
  }

  Future<List<TimerGroup>> getTimerGroupList() async {
    final List<TimerGroup> timerGroups = [];
    final timerGroupInfo =
        await ref.read(timerGroupRepositoryProvider).getAll();
    for (TimerGroup i in timerGroupInfo) {
      final tg =
          await ref.read(timerGroupRepositoryProvider).getTimerGroup(i.id!);

      timerGroups.add(
        TimerGroup(
          id: i.id,
          title: i.title,
          description: i.description,
          options: tg!.options,
          timers: tg.timers,
          totalTime: tg.totalTime,
        ),
      );
    }
    return timerGroups;
  }

  Future<int?> getEditingId() async {
    return state.value?.last.id;
  }

  // 値の操作を行う (state = StateNotifier<int>)
  Future<int> addNewGroup(TimerGroupInfo info) async {
    final id =
        await ref.read(timerGroupRepositoryProvider).addNewTimerGroup(info);
    await updateState();
    return id;
  }

  Future<void> removeGroup(int id) async {
    await ref.read(timerGroupRepositoryProvider).removeTimerGroup(id);
    await updateState();
    return;
  }

  Future<void> recoverGroup(TimerGroup timerGroup) async {
    await ref.read(timerGroupRepositoryProvider).recoverTimerGroup(timerGroup);
    await updateState();
    return;
  }

  Future<void> updateState() async {
    final value = await ref.read(timerGroupRepositoryProvider).getAll();
    state = AsyncData(value);
  }
}
