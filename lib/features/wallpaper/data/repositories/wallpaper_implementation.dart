import 'package:http/http.dart';
import 'package:space_anywhere/features/wallpaper/data/models/wallpaper_model.dart';
import 'package:space_anywhere/core/constants/api_constants.dart';
import 'package:space_anywhere/features/wallpaper/data/repositories/wallpaper_repository.dart';

class WallpaperImplementation implements WallpaperRepository {
  final Client _client;

  WallpaperImplementation({required this._client});

  @override
  Future<List<WallpaperModel?>> getWallpaper({int? offset}) async {
    final domain = baseURL.replaceFirst("https://", "");
    final path = "/api/v1/wallpapers/";
    final queryParam = {"offset": offset.toString()};

    final url = Uri.https(domain, path, queryParam);

    final response = await _client.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return WallpaperModel.listFromJson(source: response.body);
    }
    throw Exception(response.body);
  }
}
