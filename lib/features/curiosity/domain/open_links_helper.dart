import 'package:url_launcher/url_launcher.dart';

class OpenLinksHelper {
  static Future<void> openLink({required String url}) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
    } else {
      throw Exception("Erro ao acessar o link.");
    }
  }
}
