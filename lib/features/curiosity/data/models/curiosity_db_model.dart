class CuriosityDbModel {
  final int curiosityId;
  final String title;
  final String shortAnswer;
  final String longAnswer;
  final String time;

  const CuriosityDbModel({
    required this.curiosityId,
    required this.shortAnswer,
    required this.longAnswer,
    required this.title,
    required this.time,
  });
}

class FontDbModel {
  final String font;

  const FontDbModel({required this.font});
}
