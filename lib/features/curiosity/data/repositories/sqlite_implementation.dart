import 'dart:developer';
import 'package:path/path.dart';
import 'package:space_anywhere/core/constants/sqlite_constants.dart';
import 'package:space_anywhere/features/curiosity/data/repositories/sqlite_repository.dart';
import 'package:space_anywhere/features/curiosity/data/models/curiosity_db_model.dart';
import 'package:sqflite/sqflite.dart';

enum DatabaseActions { add, update }

class SqliteImplementation implements SqliteRepository {
  Database? _db;

  static final _instance = SqliteImplementation._();

  new _();

  factory instance() => _instance;

  Future<Database> get database async {
    if (_db != null) { return _db!; }

    _db = await createDatabase();
    return _db!;
  }

  @override
  Future<Database> createDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "space_anywhere.db");
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE IF NOT EXISTS $tableNameCuriosity (
            $curiosityId INTEGER PRIMARY KEY,
            $title TEXT NOT NULL,
            $shortAnswer TEXT NOT NULL,
            $longAnswer TEXT NOT NULL,
            $time TEXT NOT NULL
          )
          ''');
        db.execute('''
          CREATE TABLE IF NOT EXISTS $tableNameFonts (
            $fontsId INTEGER PRIMARY KEY AUTOINCREMENT,
            $font TEXT NOT NULL
          )
          ''');
      },
    );
    return database;
  }

  Future<CuriosityDbModel?> selectCuriosity() async {
    final db = await database;
    final data = await db.query(tableNameCuriosity);

    final formatedData = data
        .map(
          (item) => CuriosityDbModel(
            curiosityId: item[curiosityId] as int,
            title: item[title] as String,
            shortAnswer: item[shortAnswer] as String,
            longAnswer: item[longAnswer] as String,
            time: item[time] as String,
          ),
        )
        .firstOrNull;

    return formatedData;
  }

  Future<List<FontDbModel>> selectFonts() async {
    final db = await database;
    final data = await db.query(tableNameFonts);

    final formatedData = data
        .map((item) => FontDbModel(font: item[font] as String))
        .toList();

    return formatedData;
  }

  Future<void> addCuriosity({required CuriosityDbModel curiosityModel}) async {
    final db = await database;

    try {
      await db.insert(tableNameCuriosity, {
        curiosityId: curiosityModel.curiosityId,
        title: curiosityModel.title,
        shortAnswer: curiosityModel.shortAnswer,
        longAnswer: curiosityModel.longAnswer,
        time: curiosityModel.time,
      });
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> addFonts({required FontDbModel fontModel}) async {
    final db = await database;

    try {
      await db.insert(tableNameFonts, {font: fontModel.font});
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> updateCuriosity({
    required CuriosityDbModel curiosityModel,
    required int previousCuriosityId,
  }) async {
    final db = await database;
    try {
      await db.update(
        tableNameCuriosity,
        {
          curiosityId: curiosityModel.curiosityId,
          title: curiosityModel.title,
          shortAnswer: curiosityModel.shortAnswer,
          longAnswer: curiosityModel.longAnswer,
          time: curiosityModel.time,
        },
        where: "$curiosityId = ?",
        whereArgs: [previousCuriosityId],
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> deleteFonts() async {
    final db = await database;

    try {
      await db.delete(tableNameFonts);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
