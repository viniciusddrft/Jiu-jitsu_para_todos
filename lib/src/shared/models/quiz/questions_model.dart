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

  QuestionModel.fromJson(Map<String, dynamic> json)
      : question = json['question'],
        options = List.from(json['options']),
        rightAnswer = json['rightAnswer'],
        pathImage = json['pathImage'],
        pathVideo = json['pathVideo'];

  Map<String, dynamic> toJson() => {
        'question': question,
        'options': options,
        'rightAnswer': rightAnswer,
        'pathImage': pathImage,
        'pathVideo': pathVideo,
      };
}
