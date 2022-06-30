import 'package:flutter/widgets.dart';

import 'package:jiu_jitsu_para_todos/src/shared/repositories/interface/repository_api_interface.dart';

import '../../../shared/models/quiz/questions_model.dart';
import '../../../shared/repositories/repository_api.dart';

class ControllerQuiz {
  final RepositoryApi _repositoryApi = RepositoryApi();
  int numberOfQuestions = 0;
  int score = 0;

  List<QuestionModel> choice(BuildContext context,
      {required String difficulty}) {
    switch (difficulty) {
      case 'easy':
        {
          final List<QuestionModel> questionsEasy =
              QuestionModel.questionsEasy(context);

          return questionsEasy
            ..shuffle()
            ..toList().forEach(
                (QuestionModel question) => question.options.shuffle());
        }

      case 'medium':
        {
          final List<QuestionModel> questionsMedium =
              QuestionModel.questionsMedium(context);

          return questionsMedium
            ..shuffle()
            ..toList().forEach(
                (QuestionModel question) => question.options.shuffle());
        }

      case 'hard':
        {
          final List<QuestionModel> questionsHard =
              QuestionModel.questionsHard(context);

          return questionsHard
            ..shuffle()
            ..toList().forEach(
                (QuestionModel question) => question.options.shuffle());
        }

      default:
        {
          //
          final List<QuestionModel> questionsEasy =
              QuestionModel.questionsEasy(context);

          return questionsEasy
            ..shuffle()
            ..toList().forEach(
                (QuestionModel question) => question.options.shuffle());
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
