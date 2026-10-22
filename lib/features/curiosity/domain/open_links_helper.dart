import 'package:url_launcher/url_launcher.dart';

final class const OpenLinksHelper._() {
  static Future<void> openLink({required String url}) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: .inAppBrowserView);
    } else {
      throw Exception("Erro ao acessar o link.");
    }
  }
}
