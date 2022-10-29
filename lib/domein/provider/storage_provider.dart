
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/storage/sqlite.dart';

final learningDeckDatabaseProvider = Provider<SavedTimerGroup>(
      (ref) => SqliteLocalDatabase.timerGroup,
);