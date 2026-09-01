import 'package:space_anywhere/features/quiz/data/models/question_model.dart';

abstract interface class QuestionRepository {
  Future<QuestionModel?> getQuestion({required int id});
}
