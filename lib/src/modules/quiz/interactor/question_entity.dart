import 'answer_entity.dart';

class QuestionEntity {
  final String question;
  final String? pathImage, pathVideo;
  final List<AnswerEntity> options;

  const QuestionEntity(
      {required this.question,
      required this.pathImage,
      required this.pathVideo,
      required this.options});
}
