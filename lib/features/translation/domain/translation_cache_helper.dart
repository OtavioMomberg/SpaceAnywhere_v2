import 'package:space_anywhere/features/translation/data/models/language_model.dart';
import 'package:space_anywhere/features/translation/data/models/translation_model.dart';

final class const TranslationCacheHelper._() {
  static List<LanguageModel?> language = [];
  static Map<String, List<TranslationModel?>?> translation = {};
}