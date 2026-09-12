import 'dart:convert';

class QuestionModel({
  required final int id,
  required final String question,
  required final int rightAnswerIndex,
  required final List<String> alternatives
}) {
  factory fromMap({required Map<String, dynamic> map}) {
    final alternatives = (map["alternatives"] as List).cast<String>();
    
    return QuestionModel(
      id: map["id"], 
      question: map["question"], 
      alternatives: alternatives, 
      rightAnswerIndex: map["right_answer_index"]
    );
  }

  factory fromJson({required String source}) => 
    QuestionModel.fromMap(map: jsonDecode(source));
}