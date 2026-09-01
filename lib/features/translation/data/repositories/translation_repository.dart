import 'package:space_anywhere/features/translation/data/models/translation_model.dart';

abstract interface class TranslationRepository {
  Future<List<TranslationModel?>> getTrasnlations({String? langFlag});
}
