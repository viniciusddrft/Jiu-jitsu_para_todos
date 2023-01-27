class QuestionModel {
  final String question, rightAnswer;
  final List<String> options;
  final String? pathImage, pathVideo;

  QuestionModel.fromJson(Map<String, Object?> json)
      : question = json['question'] as String,
        options = List<String>.from(json['options'] as Iterable),
        rightAnswer = json['rightAnswer'] as String,
        pathImage = json['pathImage'] as String?,
        pathVideo = json['pathVideo'] as String?;

  Map<String, Object?> toJson() => {
        'question': question,
        'options': options,
        'rightAnswer': rightAnswer,
        'pathImage': pathImage,
        'pathVideo': pathVideo,
      };
}
