import 'package:space_anywhere/features/translation/data/models/language_model.dart';
import 'package:space_anywhere/features/translation/data/repositories/language_repository.dart';

class LanguageController {
  final LanguageRepository _languageRepositoryHttp;

  LanguageController(this._languageRepositoryHttp);

  String? _error;

  String? get error => _error;

  List<LanguageModel?> _languageModel = [];

  List<LanguageModel?> get languageModel => _languageModel;

  Future<void> onGetLanguages() async {
    _error = null;

    try {
      final response = await _languageRepositoryHttp.getLanguages();

      if (response.isNotEmpty) {
        _languageModel = response;
      }
    } catch (error) {
      _error = error.toString();
    }
  }
}
