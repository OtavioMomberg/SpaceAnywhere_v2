import 'dart:convert';

class CuriosityModel {
  final int id;
  final String title;
  final String shortAnswer;
  final String longAnswer;
  final List<String> contentFont;

  const CuriosityModel({
    required this.id,
    required this.title,
    required this.shortAnswer,
    required this.longAnswer,
    required this.contentFont,
  });

  factory CuriosityModel.fromMap({required Map<String, dynamic> map}) {
    final fonts = (map["content_font"] as List).cast<String>();

    return CuriosityModel(
      id: map["id"], 
      title: map["title"], 
      shortAnswer: map["short_answer"], 
      longAnswer: map["long_answer"], 
      contentFont: fonts,
    );
  }

  factory CuriosityModel.fromJson({required String source}) => CuriosityModel.fromMap(map: jsonDecode(source));
}