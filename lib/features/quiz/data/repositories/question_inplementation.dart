import 'package:http/http.dart';
import 'package:space_anywhere/features/quiz/data/models/question_model.dart';
import 'package:space_anywhere/features/quiz/data/repositories/question_repository.dart';
import 'package:space_anywhere/core/constants/api_constants.dart';

class QuestionInplementation implements QuestionRepository {
  final Client _client;

  const new({required this._client});

  @override
  Future<QuestionModel?> getQuestion({required int id}) async {
    final url = "$baseURL/api/v1/quiz/$id";
    final response = await _client.get(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return QuestionModel.fromJson(source: response.body);
    }
    throw Exception(response.body);
  }
}
