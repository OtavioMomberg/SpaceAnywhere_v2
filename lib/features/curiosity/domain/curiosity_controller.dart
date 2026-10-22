import 'package:space_anywhere/features/curiosity/data/models/curiosity_model.dart';
import 'package:space_anywhere/features/curiosity/data/repositories/curiosity_repository.dart';

final class CuriosityController({
  required final CuriosityRepository _curiosityRepository
}) {
  String? _errorGetCuriosity;

  String? get getErrorCuriosity => _errorGetCuriosity;

  bool _isSucced = false;

  bool get isSucced => _isSucced;

  void updadeIsSucced({required bool value}) => _isSucced = value;

  CuriosityModel? _curiosityModel;

  CuriosityModel? get getCuriosityModel => _curiosityModel;

  Future<void> onGetCuriosity({required int id}) async {
    _errorGetCuriosity = null;
    try {
      final response = await _curiosityRepository.getCuriosity(id: id);

      _curiosityModel = response;
      _isSucced = true;
      
    } catch (error) {
      _errorGetCuriosity = error.toString();
    }
  }
}
