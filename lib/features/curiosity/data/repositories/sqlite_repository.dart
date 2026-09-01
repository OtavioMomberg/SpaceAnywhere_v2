import 'package:sqflite/sqflite.dart';

abstract interface class SqliteRepository {
  Future<Database> createDatabase();
}
