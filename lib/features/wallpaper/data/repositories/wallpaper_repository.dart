import 'package:space_anywhere/features/wallpaper/data/models/wallpaper_model.dart';

abstract interface class WallpaperRepository {
  Future<List<WallpaperModel?>> getWallpaper({int? offset});
}
