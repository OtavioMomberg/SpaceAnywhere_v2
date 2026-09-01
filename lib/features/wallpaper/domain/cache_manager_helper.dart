import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:space_anywhere/features/wallpaper/data/models/wallpaper_model.dart';

class CacheManagerHelper {
  static const cacheKey = "wallpaper_cache";
  static const stalePeriod = Duration(days: 1);
  static const maxNrOfCacheObjects = 20;

  static final instance = CacheManager(
    Config(
      cacheKey,
      stalePeriod: stalePeriod,
      maxNrOfCacheObjects: maxNrOfCacheObjects,
    ),
  );

  static List<WallpaperModel?>? wallpapers;
}
