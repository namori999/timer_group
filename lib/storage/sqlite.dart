import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';

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
  await SqliteLocalDatabase.timerGroup._initialize(db);
  await SqliteLocalDatabase.timerGroupOptions._initialize(db);
}

abstract class SqliteLocalDatabase {
  static const timerGroup = SavedTimerGroup();
  static const timerGroupOptions = SavedOptions();
}

class SavedTimerGroup implements SqliteLocalDatabase {
  const SavedTimerGroup();

  Future<void> _initialize(Database db) async {
    await db.execute('''
CREATE TABLE IF NOT EXISTS timerGroup (
  title TEXT PRIMARY KEY, 
  description TEXT)
  ''');
  }

  Future<Map<String, TimerGroup>> getAll() async {
    final db = await _getDatabase();
    final saved = await db.query('timerGroup');
    return {for (final t in saved.map(TimerGroup.fromJson)) t.title: t};
  }

  Future<TimerGroup?> get(String title) async {
    final db = await _getDatabase();
    final result =
        await db.query('timerGroup', where: 'title = ?', whereArgs: [title]);
    if (result.isEmpty) return null;
    return TimerGroup.fromJson(result[0]);
  }

  Future<void> insert(TimerGroup timerGroup) async {
    final db = await _getDatabase();
    print("insert timer group: $SavedTimerGroup");
    await db.insert(
      'timerGroup',
      timerGroup.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> delete(String title) async {
    final db = await _getDatabase();
    await db.delete('timerGroup', where: 'title = ?', whereArgs: [title]);
  }
}

class SavedOptions implements SqliteLocalDatabase {
  const SavedOptions();

  get title => null;

  Future<void> _initialize(Database db) async {
    await db.execute(
      '''
CREATE TABLE IF NOT EXISTS timerGroupOptions (
  title TEXT PRIMARY KEY,
  timeFormat TEXT,
  overTime TEXT)
  ''',
    );
  }

  Future<TimerGroupOptions?> get(String title) async {
    final db = await _getDatabase();
    final result = await db.query('timerGroupOptions',
        where: 'title = ?', whereArgs: [title]);
    if (result.isEmpty) return null;
    return TimerGroupOptions.fromJson(result[0]);
  }

  Future<void> insert(TimerGroupOptions options) async {
    final db = await _getDatabase();
    print("insert options: options=$options");
    await db.insert(
      'timerGroupOptions',
      options.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> delete(String title) async {
    final db = await _getDatabase();
    await db.delete('timerGroupOptions',
        where: 'title = ?', whereArgs: [title]);
  }
}
