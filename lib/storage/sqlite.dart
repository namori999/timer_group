import 'dart:async';
import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/domein/models/timer_group_info.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';

const int _databaseVersion = 2;
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
  );
}

Future<void> _initDatabase(Database db, int oldVersion, int newVersion) async {
  await SqliteLocalDatabase.timerGroup._initialize(db);
  await SqliteLocalDatabase.timerGroupOptions._initialize(db);
  await SqliteLocalDatabase.timers._initialize(db);
}

abstract class SqliteLocalDatabase {
  static const timerGroup = SavedTimerGroup();
  static const timerGroupOptions = SavedOptions();
  static const timers = Timers();
}

class SavedTimerGroup implements SqliteLocalDatabase {
  const SavedTimerGroup();

  Future<void> _initialize(Database db) async {
    await db.execute('''
CREATE TABLE IF NOT EXISTS timerGroup (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT, 
  description TEXT)
  ''');
  }

  @override
  Future<void> onCreate(Database db) async {
    await _initialize(db);
  }

  Future<List<TimerGroup>> getAll() async {
    final db = await _getDatabase();
    final saved = await db.query('timerGroup');
    return saved.map(TimerGroup.fromJson).toList();
  }

  Future<TimerGroup> get(int id) async {
    final db = await _getDatabase();
    final rows =
        await db.rawQuery('SELECT * FROM timerGroup WHERE id = ?', [id]);
    return TimerGroup.fromJson(rows.first);
  }

  Future<int> getId(String title) async {
    final db = await _getDatabase();
    final rows =
        await db.rawQuery('SELECT * FROM timerGroup WHERE title = ?', [title]);
    final result = rows.first;
    return result.values.first as int;
  }

  Future<int> insert(TimerGroupInfo timerGroupInfo) async {
    final db = await _getDatabase();
    print("insert timer group: $timerGroupInfo");
    final insertedId = await db.insert(
      'timerGroup',
      timerGroupInfo.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return insertedId;
  }

  Future<void> update(int id, TimerGroupInfo timerGroupInfo) async {
    final db = await _getDatabase();
    print("update timer group: $id,$timerGroupInfo");
    await db.update("timerGroup", timerGroupInfo.toJson(),
        where: "id = ?", whereArgs: [id]);
  }

  Future<void> delete(int id) async {
    final db = await _getDatabase();
    await db.delete('timerGroup', where: 'id = ?', whereArgs: [id]);
  }
}

class SavedOptions implements SqliteLocalDatabase {
  const SavedOptions();

  get title => null;

  Future<void> _initialize(Database db) async {
    await db.execute(
      '''
CREATE TABLE IF NOT EXISTS timerGroupOptions (
  id INT PRIMARY KEY,
  title TEXT,
  timeFormat TEXT,
  overTime TEXT)
  ''',
    );
  }

  Future<List<TimerGroupOptions>> getAll() async {
    final db = await _getDatabase();
    final saved = await db.query('timerGroupOptions');
    return saved.map(TimerGroupOptions.fromJson).toList();
  }

  Future<TimerGroupOptions> get(int id) async {
    final db = await _getDatabase();
    final result = await db.query(
      'timerGroupOptions',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isEmpty) return TimerGroupOptions(id: id, title: title);
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

  Future<void> update(TimerGroupOptions options) async {
    final db = await _getDatabase();
    print("update options: options=$options");
    await db.update('timerGroupOptions', options.toJson(),
        where: 'id = ?', whereArgs: [options.id]);
  }

  Future<void> delete(int id) async {
    final db = await _getDatabase();
    await db.delete('timerGroupOptions', where: 'id = ?', whereArgs: [id]);
  }
}

class Timers implements SqliteLocalDatabase {
  const Timers();

  Future<void> _initialize(Database db) async {
    await db.execute(
      '''
CREATE TABLE IF NOT EXISTS timers (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  groupId INTEGER,
  number INTEGER,
  time INTEGER,
  soundPath TEXT,
  bgmPath TEXT,
  imagePath TEXT,
  notification TEXT)
  ''',
    );
  }

  @override
  Future<void> onCreate(Database db) async {
    await _initialize(db);
  }

  Future<List<Timer>> getTimers(int groupId) async {
    final db = await _getDatabase();
    final saved = await db.query(
      'timers',
      where: 'groupId = ?',
      whereArgs: [groupId],
    );
    return saved.map(Timer.fromJson).toList();
  }

  Future<Timer> getTimer(int groupId, int number) async {
    final db = await _getDatabase();
    final result = await db.rawQuery(
        'SELECT * FROM timers WHERE groupId = ? and number = ?',
        [groupId, number]);
    return result.map(Timer.fromJson).first;
  }

  Future<void> insert(Timer timer) async {
    final db = await _getDatabase();
    print("insert timers: timers=$timer");
    await db.insert(
      'timers',
      timer.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertTimerList(List<Timer> timers) async {
    final db = await _getDatabase();

    timers.forEach((timer) async {
      print("insert timers: timers=$timer");
      await db.insert(
        'timers',
        timer.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  Future<void> update(Timer timer) async {
    final db = await _getDatabase();
    print("update timer: timer = $timer");
    await db.update('timers', timer.toJson(),
        where: 'groupId = ? and number = ?',
        whereArgs: [timer.groupId, timer.number]);
  }

  Future<void> delete(int groupId, int number) async {
    final db = await _getDatabase();
    await db.delete('timers',
        where: 'groupId = ? and number = ?', whereArgs: [groupId, number]);
    print("deleted: $db");
  }

  Future<void> deleteAllTimers(int groupId) async {
    final db = await _getDatabase();
    await db.delete('timers', where: 'groupId = ?', whereArgs: [groupId]);
  }

  Future calculateTotal(int id) async {
    final db = await _getDatabase();
    var result = await db.rawQuery(
        'select sum(number) as Total from timers where refID = ?', [id]);
    print(result.toList());
    return result.toList();
  }

  Future<int?> getTotal(int id) async {
    final db = await _getDatabase();
    var result = await db
        .rawQuery("SELECT SUM(time) FROM timers where groupId = ?", [id]);
    var value = result[0]["SUM(time)"] ;

    if (value == null) {
      return 0;
    }

    int resultInt = result[0]["SUM(time)"] as int;
    resultInt.toStringAsFixed(2);
    return resultInt;
  }
}
