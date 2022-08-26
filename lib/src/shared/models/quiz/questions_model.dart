class QuestionModel {
  final String question;
  final List<String> options;
  final String rightAnswer;
  final String? pathImage;
  final String? pathVideo;
  const QuestionModel({
    required this.question,
    required this.options,
    required this.rightAnswer,
    this.pathImage,
    this.pathVideo,
  });

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
