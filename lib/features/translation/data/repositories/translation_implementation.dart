import 'package:http/http.dart';
import 'package:space_anywhere/core/constants/api_constants.dart';
import 'package:space_anywhere/features/translation/data/models/translation_model.dart';
import 'package:space_anywhere/features/translation/data/repositories/translation_repository.dart';

final class TranslationImplementation({
  required final Client _client
}) implements TranslationRepository {
  @override
  Future<List<TranslationModel?>> getTrasnlations({String? langFlag}) async {
    final domain = baseURL.replaceFirst("https://", "");
    final path = "/api/v1/translation/";
    final queryParam = {"language": langFlag};

    final url = Uri.https(domain, path, queryParam);

    final response = await _client.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return TranslationModel.fromList(source: response.body);
    }
    throw Exception(response.body);
  }
}
