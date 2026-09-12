import 'dart:convert';

class CuriosityModel({
  required final int id,
  required final String title,
  required final String shortAnswer,
  required final String longAnswer,
  required final List<String> contentFont,
  }) {
  factory fromMap({required Map<String, dynamic> map}) {
    final fonts = (map["content_font"] as List).cast<String>();

    return CuriosityModel(
      id: map["id"], 
      title: map["title"], 
      shortAnswer: map["short_answer"], 
      longAnswer: map["long_answer"], 
      contentFont: fonts,
    );
  }

  factory fromJson({required String source}) => 
    CuriosityModel.fromMap(map: jsonDecode(source));
}