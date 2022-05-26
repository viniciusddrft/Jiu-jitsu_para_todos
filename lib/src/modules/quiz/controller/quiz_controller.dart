import 'package:flutter/widgets.dart';

import '../model/questions_model.dart';

class ControllerQuiz {
  int numberOfQuestions = 0;
  int score = 0;

  List<QuestionsModel> choice(BuildContext context,
      {required String difficulty}) {
    switch (difficulty) {
      case 'easy':
        {
          final List<QuestionsModel> questionsEasy =
              QuestionsModel.questionsEasy(context);

          return questionsEasy
            ..shuffle()
            ..toList().forEach(
                (QuestionsModel question) => question.options.shuffle());
        }

      case 'medium':
        {
          final List<QuestionsModel> questionsMedium =
              QuestionsModel.questionsMedium(context);

          return questionsMedium
            ..shuffle()
            ..toList().forEach(
                (QuestionsModel question) => question.options.shuffle());
        }

      case 'hard':
        {
          final List<QuestionsModel> questionsHard =
              QuestionsModel.questionsHard(context);

          return questionsHard
            ..shuffle()
            ..toList().forEach(
                (QuestionsModel question) => question.options.shuffle());
        }

      default:
        {
          //
          final List<QuestionsModel> questionsEasy =
              QuestionsModel.questionsEasy(context);

          return questionsEasy
            ..shuffle()
            ..toList().forEach(
                (QuestionsModel question) => question.options.shuffle());
        }
    }
  }

  String textQuestionReturn(myQuestions) =>
      myQuestions.toList()[numberOfQuestions].question;

  String returnTextAnswerA(myQuestions) =>
      myQuestions.toList()[numberOfQuestions].options[0];

  String returnTextAnswerB(myQuestions) =>
      myQuestions.toList()[numberOfQuestions].options[1];

  String returnTextAnswerC(myQuestions) =>
      myQuestions.toList()[numberOfQuestions].options[2];

  String returnTextAnswerD(myQuestions) =>
      myQuestions.toList()[numberOfQuestions].options[3];

  bool checkAnswer(String answer, myQuestions) =>
      answer == myQuestions.toList()[numberOfQuestions].rightAnswer;

  String returnPathImage(myQuestions) =>
      myQuestions.toList()[numberOfQuestions].pathImage;

  String returnPathVideo(myQuestions) =>
      myQuestions.toList()[numberOfQuestions].pathVideo;

  bool existImage(myQuestions) =>
      myQuestions.toList()[numberOfQuestions].pathImage != null;

  bool existVideo(myQuestions) =>
      myQuestions.toList()[numberOfQuestions].pathVideo != null;
}
