import 'package:space_anywhere/features/curiosity/data/models/curiosity_db_model.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class SqliteRepository {
  Future<Database> createDatabase();

  Future<CuriosityDbModel?> selectCuriosity();

  Future<List<FontDbModel>> selectFonts();
  
  Future<void> addCuriosity({required CuriosityDbModel curiosityModel});

  Future<void> addFonts({required FontDbModel fontModel});
  
  Future<void> updateCuriosity({
    required CuriosityDbModel curiosityModel,
    required int previousCuriosityId,
  });
  
  Future<void> deleteFonts();
}
