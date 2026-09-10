import 'package:space_anywhere/features/translation/data/models/language_model.dart';
import 'package:space_anywhere/features/translation/data/repositories/language_repository.dart';

class LanguageController {
  final LanguageRepository _languageRepository;

  LanguageController(this._languageRepository);

  String? _error;

  String? get error => _error;

  bool _isSucced = false;

  bool get isSucced => _isSucced;

  set initIsSucced(bool value) => _isSucced = value;

  set isSuccedTrue(bool value) => _isSucced = value;

  List<LanguageModel?> _languageModel = [];

  List<LanguageModel?> get languageModel => _languageModel;

  Future<void> onGetLanguages() async {
    _error = null;

    try {
      final response = await _languageRepository.getLanguages();

      if (response.isNotEmpty) {
        _languageModel = response;
        _isSucced = true;
      }
    } catch (error) {
      _error = error.toString();
    }
  }
}
