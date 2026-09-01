import 'dart:convert';

class WallpaperModel {
  final int id;
  final String fullImageUrl;
  final String thumbnailImageUrl;

  const WallpaperModel({
    required this.id,
    required this.fullImageUrl,
    required this.thumbnailImageUrl
  });

  factory WallpaperModel.fromMap({required Map<String, dynamic> map}) {
    return WallpaperModel(
      id: map["id"], 
      fullImageUrl: map["full_image_url"], 
      thumbnailImageUrl: map["thumbnail_image_url"]
    );
  }

  static List<WallpaperModel> listFromJson({required String source}) {
    final decoded = (jsonDecode(source) as List).cast<Map<String, dynamic>>();
    final wallpaperList = decoded.map((item) => WallpaperModel.fromMap(map: item)).toList();
    
    return wallpaperList;
  }
}