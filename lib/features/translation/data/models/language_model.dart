import 'dart:convert';

class LanguageModel({
  required final String lang,
  required final String langFlag,
  required final String emoji
}) {
  factory fromMap({required Map<String, dynamic> map}) {
    return LanguageModel(
      lang: map["lang"], 
      langFlag: map["lang_flag"],
      emoji: map["emoji"]
    );
  }

  static List<LanguageModel> fromList({required String source}) {
    final decoded = (jsonDecode(source) as List).cast<Map<String, dynamic>>();
    final languages = decoded.map((item) => LanguageModel.fromMap(map: item)).toList();

    return languages;
  }
}