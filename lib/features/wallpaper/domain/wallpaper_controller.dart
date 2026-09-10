import 'package:space_anywhere/features/wallpaper/data/models/wallpaper_model.dart';
import 'package:space_anywhere/features/wallpaper/data/repositories/wallpaper_repository.dart';

class WallpaperController {
  final WallpaperRepository _wallpaperRepository;

  WallpaperController(this._wallpaperRepository);

  String? _errorGetWallpaper;

  String? get getErrorWallpaper => _errorGetWallpaper;

  bool _isSucced = false;

  bool get isSucced => _isSucced;

  set initIsSucced(bool value) => _isSucced = value;

  List<WallpaperModel?> _wallpaperModel = [];

  List<WallpaperModel?> get getWallpaperModel => _wallpaperModel;

  Future<void> onGetWallpaper({int? offset}) async {
    _errorGetWallpaper = null;
    try {
      final response = await _wallpaperRepository.getWallpaper(
        offset: offset,
      );

      if (response.isNotEmpty) {
        _wallpaperModel = response;
        _isSucced = true;
      }
    } catch (error) {
      _errorGetWallpaper = error.toString();
    }
  }
}
