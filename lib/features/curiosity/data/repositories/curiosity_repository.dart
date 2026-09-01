import 'package:space_anywhere/features/curiosity/data/models/curiosity_model.dart';

abstract interface class CuriosityRepository {
  Future<CuriosityModel?> getCuriosity({required int id});
}
