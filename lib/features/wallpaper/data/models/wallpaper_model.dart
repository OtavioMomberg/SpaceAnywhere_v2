import 'dart:convert';

class WallpaperModel({
  required final int id,
  required final String fullImageUrl,
  required final String thumbnailImageUrl
}) {
  factory fromMap({required Map<String, dynamic> map}) {
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