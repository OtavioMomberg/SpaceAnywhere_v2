import 'package:space_anywhere/features/quiz/data/models/question_model.dart';
import 'package:space_anywhere/features/quiz/data/repositories/question_repository.dart';

final class QuestionController({
  required final QuestionRepository _questionRepository
}) {
  String? _errorGetQuestion;

  String? get getErrorQuestion => _errorGetQuestion;

  bool _isSucced = false;

  bool get isSucced => _isSucced;

  void updadeIsSucced({required bool value}) => _isSucced = value;

  QuestionModel? _questionModel;

  QuestionModel? get getQuestionModel => _questionModel;

  Future<void> onGetQuestion({required int id}) async {
    _errorGetQuestion = null;
    try {
      final response = await _questionRepository.getQuestion(id: id);

      _questionModel = response;
      _isSucced = true;

    } catch (error) {
      _errorGetQuestion = error.toString();
    }
  }
}
