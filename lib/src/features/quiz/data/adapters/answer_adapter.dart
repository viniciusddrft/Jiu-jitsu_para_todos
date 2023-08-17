import 'package:jiu_jitsu_para_todos/src/features/quiz/interector/answer_entity.dart';

class AnswerAdapter {
  static AnswerEntity fromJson(Map<String, dynamic> json) => AnswerEntity(
        text: json['text'],
        isCorrect: json['isCorrect'],
      );

  static Map<String, dynamic> toJson(AnswerEntity answerEntity) => {
        'text': answerEntity.text,
        'isCorrect': answerEntity.isCorrect,
      };
}
