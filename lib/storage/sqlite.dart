import 'dart:async';
import 'dart:io' as io;

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timer_group/domein/models/saved_image.dart';
import 'package:timer_group/domein/models/sound.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/models/timer_group.dart';
import 'package:timer_group/domein/models/timer_group_info.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';

const int _databaseVersion = 3;
Database? _database;

Future<String> _getDbDirectory() async {
  if (io.Platform.isAndroid) {
    return await getDatabasesPath();
  } else if (io.Platform.isIOS) {
    return (await getLibraryDirectory()).path;
  } else {
    throw Exception('Unable to determine platform.');
  }
}

Future<Database> _getDatabase() async {
  final dbPath = join(await _getDbDirectory(), 'local.db');
  return _database ??= await openDatabase(dbPath,
      version: _databaseVersion,
      onCreate: (db, version) async => await _initDatabase(db, -1, version),
      onUpgrade: (db, oldVersion, newVersion) async {
        for (var i = oldVersion + 1; i <= newVersion; i++) {
          var queries = scripts[i.toString()];
          for (String query in queries!) {
            await db.execute(query);
          }
          _initDatabase(db, oldVersion, newVersion);
        }
      });
}

const scripts = {
  '3': [
    'ALTER TABLE timers ADD COLUMN isOverTime INTEGER;',
    '''
CREATE TABLE IF NOT EXISTS pickedFiles (
  id INT PRIMARY KEY AUTOINCREMENT,
  url TEXT,
  name TEXT,
  type TEXT)
  '''
  ],
};

Future<void> _initDatabase(Database db, int oldVersion, int newVersion) async {
  await SqliteLocalDatabase.timerGroup._initialize(db);
  await SqliteLocalDatabase.timerGroupOptions._initialize(db);
  await SqliteLocalDatabase.timers._initialize(db);
  await SqliteLocalDatabase.pickedFiles._initialize(db);
}

abstract class SqliteLocalDatabase {
  static const timerGroup = SavedTimerGroup();
  static const timerGroupOptions = SavedOptions();
  static const timers = Timers();
  static const pickedFiles = PickedFiles();
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
    if (result.isEmpty) return TimerGroupOptions(id: id);
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
  groupId INTEGER,
  number INTEGER PRIMARY KEY,
  time INTEGER,
  alarmName TEXT,
  alarmUrl TEXT,
  bgmName TEXT,
  bgmUrl TEXT,
  imagePath TEXT,
  notification INTEGER,
  isOverTime INTEGER)
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
      timer.toMap(),
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
    await db.update('timers', timer.toMap(),
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

  Future<int> getTotal(int id) async {
    final db = await _getDatabase();
    var result = await db
        .rawQuery("SELECT SUM(time) FROM timers where groupId = ?", [id]);
    var value = result[0]["SUM(time)"];

    if (value == null) {
      return 0;
    }

    int resultInt = result[0]["SUM(time)"] as int;
    resultInt.toStringAsFixed(2);
    return resultInt;
  }
}

class PickedFiles implements SqliteLocalDatabase {
  const PickedFiles();

  Future<void> _initialize(Database db) async {
    await db.execute(
      '''
CREATE TABLE IF NOT EXISTS pickedFiles (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  url TEXT,
  name TEXT,
  type TEXT)
  ''',
    );
  }

  Future<List<SavedImage>> getImages() async {
    final db = await _getDatabase();
    final result = await db.query(
      'pickedFiles',
      where: 'type = ?',
      whereArgs: ['image'],
    );
    if (result.isEmpty) {
      return [];
    }
    return List.generate(result.length, (i) {
      return SavedImage(
        id: result[i]['id'].toString(),
        name: result[i]['name'].toString(),
        url: result[i]['url'].toString(),
      );
    });
  }

  Future<List<Sound>> getBGMs() async {
    final db = await _getDatabase();
    final result = await db.query(
      'pickedFiles',
      where: 'type = ?',
      whereArgs: ['bgm'],
    );
    if (result.isEmpty) {
      return [];
    }
    return List.generate(result.length, (i) {
      return Sound(
        name: result[i]['name'].toString(),
        url: result[i]['url'].toString(),
      );
    });
  }

  Future<List<Sound>> getAlarms() async {
    final db = await _getDatabase();
    final result = await db.query(
      'pickedFiles',
      where: 'type = ?',
      whereArgs: ['alarm'],
    );
    if (result.isEmpty) {
      return [];
    }
    return List.generate(result.length, (i) {
      return Sound(
        name: result[i]['name'].toString(),
        url: result[i]['url'].toString(),
      );
    });
  }

  Future<void> insertImage(SavedImage savedImage) async {
    final db = await _getDatabase();
    print("insert pickedFiles: pickedFiles=$savedImage");
    await db.rawInsert(
        'INSERT OR REPLACE INTO pickedFiles(name, url, type) VALUES (?, ?, ?)',
        [savedImage.name, savedImage.url, 'image']);
  }

  Future<void> insertBGM(Sound bgm) async {
    final db = await _getDatabase();
    await db.rawInsert(
        'INSERT OR REPLACE INTO pickedFiles(name, url, type) VALUES (?, ?, ?)',
        [bgm.name, bgm.url, 'bgm']);
    print("insert pickedFiles: pickedFiles=$bgm");
  }

  Future<void> insertAlarm(Sound alarm) async {
    final db = await _getDatabase();
    await db.rawInsert(
        'INSERT OR REPLACE INTO pickedFiles(name, url, type) VALUES (?, ?, ?)',
        [alarm.name, alarm.url, 'alarm']);
    print("insert pickedFiles: pickedFiles=$alarm");
  }

  Future<void> update(TimerGroupOptions options) async {
    final db = await _getDatabase();
    print("update options: options=$options");
    await db.update('timerGroupOptions', options.toJson(),
        where: 'id = ?', whereArgs: [options.id]);
  }

  Future<void> delete(String id) async {
    final db = await _getDatabase();
    await db.delete('pickedFiles', where: 'id = ?', whereArgs: [id]);
  }
}
