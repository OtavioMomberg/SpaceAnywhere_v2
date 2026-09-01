import 'dart:convert';

class QuestionModel {
  final int id;
  final String question;
  final int rightAnswerIndex;
  final List<String> alternatives;

  const QuestionModel({
    required this.id,
    required this.question,
    required this.rightAnswerIndex,
    required this.alternatives
  });

  factory QuestionModel.fromMap({required Map<String, dynamic> map}) {
    final alternatives = (map["alternatives"] as List).cast<String>();
    
    return QuestionModel(
      id: map["id"], 
      question: map["question"], 
      alternatives: alternatives, 
      rightAnswerIndex: map["right_answer_index"]
    );
  }

  factory QuestionModel.fromJson({required String source}) => QuestionModel.fromMap(map: jsonDecode(source));
}