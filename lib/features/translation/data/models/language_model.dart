import 'dart:convert';

class LanguageModel {
  final String lang;
  final String langFlag;
  final String emoji;

  const LanguageModel({
    required this.lang,
    required this.langFlag,
    required this.emoji
  });

  factory LanguageModel.fromMap({required Map<String, dynamic> map}) {
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