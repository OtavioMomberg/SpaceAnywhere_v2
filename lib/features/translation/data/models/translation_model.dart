import 'dart:convert';

class TranslationModel({
  required final int id,
  required final String translation,
  required final String langFlag
}) {
  factory fromMap({required Map<String, dynamic> map}) {
    return TranslationModel(
      id: map["id"], 
      translation: map["translation"], 
      langFlag: map["lang_flag"]
    );
  }

  static List<TranslationModel> fromList({required String source}) {
    final decoded = (jsonDecode(source) as List).cast<Map<String, dynamic>>();
    final translations = decoded.map((item) => TranslationModel.fromMap(map: item)).toList();

    return translations;
  }
}