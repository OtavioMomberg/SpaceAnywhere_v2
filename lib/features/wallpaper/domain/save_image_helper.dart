import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';

enum ImageOption { network, asset }

class SaveImageHelper {
  static Future<bool> saveImageFromAsset({required String imagePath}) async {
    final byteData = await rootBundle.load(imagePath);
    final imageBytes = byteData.buffer.asUint8List();

    return _saveToGallery(imageBytes: imageBytes);
  }

  static Future<bool> saveImageFromUrl({required String imageUrl}) async {
    final response = await http.get(Uri.parse(imageUrl));
    final imageBytes = response.bodyBytes;

    return _saveToGallery(imageBytes: imageBytes);
  }

  static Future<bool> _saveToGallery({required Uint8List imageBytes}) async {
    final response = await ImageGallerySaverPlus.saveImage(
      imageBytes,
      quality: 100
    );

    return response["isSuccess"] == true;
  }
}
