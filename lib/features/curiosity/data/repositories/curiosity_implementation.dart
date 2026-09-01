import 'package:http/http.dart';
import 'package:space_anywhere/features/curiosity/data/models/curiosity_model.dart';
import 'package:space_anywhere/features/curiosity/data/repositories/curiosity_repository.dart';
import 'package:space_anywhere/core/constants/api_constants.dart';

class CuriosityImplementation implements CuriosityRepository {
  final Client _client;

  CuriosityImplementation({required Client client}) : _client = client;

  @override
  Future<CuriosityModel?> getCuriosity({required int id}) async {
    final url = "$baseURL/api/v1/curiosity/$id";
    final response = await _client.get(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return CuriosityModel.fromJson(source: response.body);
    }
    throw Exception(response.body);
  }
}
