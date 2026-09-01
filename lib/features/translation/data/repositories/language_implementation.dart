import 'package:http/http.dart';
import 'package:space_anywhere/core/constants/api_constants.dart';
import 'package:space_anywhere/features/translation/data/models/language_model.dart';
import 'package:space_anywhere/features/translation/data/repositories/language_repository.dart';

class LanguageImplementation implements LanguageRepository {
  final Client _client;

  const LanguageImplementation({required Client client}) : _client = client;

  @override
  Future<List<LanguageModel?>> getLanguages() async {
    final url = "$baseURL/api/v1/translation/languages";

    final response = await _client.get(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return LanguageModel.fromList(source: response.body);
    }
    throw Exception(response.body);
  }
}
