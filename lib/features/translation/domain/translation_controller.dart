import 'package:space_anywhere/core/constants/app_constants.dart';
import 'package:space_anywhere/features/translation/data/models/translation_model.dart';
import 'package:space_anywhere/features/translation/data/repositories/translation_repository.dart';

class TranslationController {
  final TranslationRepository _translationRepositoryHttp;

  TranslationController(this._translationRepositoryHttp);

  String? _error;

  String? get error => _error;

  List<TranslationModel?> _translationModel = [];

  List<TranslationModel?> get translationModel => _translationModel;

  set cacheTranslationModel(List<TranslationModel?> translation) =>
      _translationModel = translation;

  Future<void> onGetTranslations({String? langFlag}) async {
    _error = null;
    try {
      final response = await _translationRepositoryHttp.getTrasnlations(
        langFlag: langFlag ?? defaultLangFlag,
      );

      if (response.isNotEmpty) {
        _translationModel = response;
      }
    } catch (error) {
      _error = error.toString();
    }
  }
}
