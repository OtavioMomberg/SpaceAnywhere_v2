import 'package:space_anywhere/features/curiosity/data/models/curiosity_model.dart';
import 'package:space_anywhere/features/curiosity/data/repositories/curiosity_repository.dart';

class CuriosityController {
  final CuriosityRepository _curiosityRepository;

  new({required this._curiosityRepository});

  String? _errorGetCuriosity;

  String? get getErrorCuriosity => _errorGetCuriosity;

  bool _isSucced = false;

  bool get isSucced => _isSucced;

  set initIsSucced(bool value) => _isSucced = value;

  set isSuccedTrue(bool value) => _isSucced = value;

  CuriosityModel? _curiosityModel;

  CuriosityModel? get getCuriosityModel => _curiosityModel;

  Future<void> onGetCuriosity({required int id}) async {
    _errorGetCuriosity = null;
    try {
      final response = await _curiosityRepository.getCuriosity(id: id);

      if (response != null) {
        _curiosityModel = response;
        _isSucced = true;
      }
    } catch (error) {
      _errorGetCuriosity = error.toString();
    }
  }
}
