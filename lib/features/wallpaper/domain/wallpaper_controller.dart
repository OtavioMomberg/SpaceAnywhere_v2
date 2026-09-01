import 'package:space_anywhere/features/wallpaper/data/models/wallpaper_model.dart';
import 'package:space_anywhere/features/wallpaper/data/repositories/wallpaper_repository.dart';

class WallpaperController {
  final WallpaperRepository _wallpaperRepositoryHttp;

  WallpaperController(this._wallpaperRepositoryHttp);

  String? _errorGetWallpaper;

  String? get getErrorWallpaper => _errorGetWallpaper;

  List<WallpaperModel?> _wallpaperModel = [];

  List<WallpaperModel?> get getWallpaperModel => _wallpaperModel;

  Future<void> onGetWallpaper({int? offset}) async {
    _errorGetWallpaper = null;
    try {
      final response = await _wallpaperRepositoryHttp.getWallpaper(
        offset: offset,
      );

      if (response.isNotEmpty) {
        _wallpaperModel = response;
      }
    } catch (error) {
      _errorGetWallpaper = error.toString();
    }
  }
}
