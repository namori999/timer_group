import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';

/*
 * SQLite に保存したほうが良いデータ
 * - 同じようなものが多数集まっているデータ
 */
const int _databaseVersion = 1;
Database? _database;

Future<String> _getDbDirectory() async {
  if (Platform.isAndroid) {
    return await getDatabasesPath();
  } else if (Platform.isIOS) {
    return (await getLibraryDirectory()).path;
  } else {
    throw Exception('Unable to determine platform.');
  }
}

Future<Database> _getDatabase() async {
  final dbPath = join(await _getDbDirectory(), 'local.db');
  return _database ??= await openDatabase(
    dbPath,
    version: _databaseVersion,
    onCreate: (db, version) async => await _initDatabase(db, -1, version),
    onUpgrade: (db, oldVersion, newVersion) async =>
        await _initDatabase(db, oldVersion, newVersion),
    // onDowngrade: (db, oldVersion, newVersion) async => await deleteDatabase(dbPath),
    // onOpen: (db) async {
    //  // deleteDatabase(dbPath);
    //  //  logger.d(await db.query('sqlite_master'));
    // },
  );
}

Future<void> _initDatabase(Database db, int oldVersion, int newVersion) async {
  await SqliteLocalDatabase.timerGroupOptions._initialize(db);
}

abstract class SqliteLocalDatabase {
  static const timerGroupOptions = SavedTimerGroupOptions();
}

class SavedTimerGroupOptions implements SqliteLocalDatabase {
  const SavedTimerGroupOptions();

  Future<void> _initialize(Database db) async {
    await db.execute(
      '''
CREATE TABLE IF NOT EXISTS timerGroupOptions (
  timerGroupId INTEGER PRIMARY KEY AUTOINCREMENT,
  timeFormat TEXT,
  overTime TEXT)
''',
    );
  }

  Future<Map<int, TimerGroupOptions>> getAll() async {
    final db = await _getDatabase();
    final saved = await db.query('timerGroupOptions');
    return {
      for (final t in saved.map(TimerGroupOptions.fromJson)) t.timerGroupId: t
    };
  }

  Future<TimerGroupOptions?> get(String deckId) async {
    final db = await _getDatabase();
    final result = await db
        .query('timerGroupOptions', where: 'deckId = ?', whereArgs: [deckId]);
    if (result.isEmpty) return null;
    return TimerGroupOptions.fromJson(result[0]);
  }

  Future<void> insert(TimerGroupOptions options) async {
    final db = await _getDatabase();
    print("insert options: groupId=$options");
    await db.insert(
      'timerGroupOptions',
      options.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> delete(String timerGroupId) async {
    final db = await _getDatabase();
    await db.delete('timerGroupOptions',
        where: 'timerGroupId = ?', whereArgs: [timerGroupId]);
  }
}
