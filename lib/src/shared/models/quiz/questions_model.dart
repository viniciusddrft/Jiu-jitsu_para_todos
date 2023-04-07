class QuestionModel {
  final String question, rightAnswer;
  final String? pathImage, pathVideo;
  final List<String> options;

  QuestionModel.fromJson(Map<String, Object?> json)
      : question = json['question'] as String,
        options = List<String>.from(json['options'] as Iterable),
        rightAnswer = json['rightAnswer'] as String,
        pathImage = json['pathImage'] as String?,
        pathVideo = json['pathVideo'] as String?;
}
