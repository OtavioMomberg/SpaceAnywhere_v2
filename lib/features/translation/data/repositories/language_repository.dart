import 'package:space_anywhere/features/translation/data/models/language_model.dart';

abstract interface class LanguageRepository {
  Future<List<LanguageModel?>> getLanguages();
}
