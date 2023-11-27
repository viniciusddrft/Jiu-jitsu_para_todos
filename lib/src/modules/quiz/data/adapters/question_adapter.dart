import 'package:jiu_jitsu_para_todos/src/modules/quiz/data/adapters/answer_adapter.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/interector/answer_entity.dart';
import '../../interector/question_entity.dart';

class QuestionAdapter {
  static QuestionEntity fromJson(Map<String, dynamic> json) => QuestionEntity(
        question: json['question'],
        pathImage: json['pathImage'],
        pathVideo: json['pathVideo'],
        options: (json['options'] as List)
            .map<AnswerEntity>((e) => AnswerAdapter.fromJson(e))
            .toList(),
      );

  static Map<String, dynamic> toJson(QuestionEntity questionEntity) => {
        'question': questionEntity.question,
        'pathImage': questionEntity.pathImage,
        'pathVideo': questionEntity.pathVideo,
        'options': questionEntity.options
      };
}
