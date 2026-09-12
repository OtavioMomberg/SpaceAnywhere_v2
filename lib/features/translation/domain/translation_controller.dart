import 'package:space_anywhere/core/constants/app_constants.dart';
import 'package:space_anywhere/features/translation/data/models/translation_model.dart';
import 'package:space_anywhere/features/translation/data/repositories/translation_repository.dart';

class TranslationController {
  final TranslationRepository _translationRepository;

  new({required this._translationRepository});

  String? _error;

  String? get error => _error;

  bool _isSucced = false;

  bool get isSucced => _isSucced;

  set initIsSucced(bool value) => _isSucced = value;

  set isSuccedTrue(bool value) => _isSucced = value;

  List<TranslationModel?> _translationModel = [];

  List<TranslationModel?> get translationModel => _translationModel;

  set cacheTranslationModel(List<TranslationModel?> translation) => _translationModel = translation;

  Future<void> onGetTranslations({String? langFlag}) async {
    _error = null;
    try {
      final response = await _translationRepository.getTrasnlations(
        langFlag: langFlag ?? defaultLangFlag,
      );

      if (response.isNotEmpty) {
        _translationModel = response;
        _isSucced = true;
      }
    } catch (error) {
      _error = error.toString();
    }
  }
}
