import 'package:jiu_jitsu_para_todos/src/modules/quiz/model/quiz_questions_model.dart';

class ControllerQuiz {
  int numberOfQuestions = 0;
  int score = 0;

  List<Question> _questionsEasy = dataQuestionsEasy
      .map(
        (question) => Question(
            question: question['question'],
            options: question['options'],
            rightAnswer: question['rightAnswer'],
            pathImage: question?['pathImage'],
            pathVideo: question?['pathVideo']),
      )
      .toList();
  List<Question> _questionsMedium = dataQuestionsMedium
      .map(
        (question) => Question(
            question: question['question'],
            options: question['options'],
            rightAnswer: question['rightAnswer'],
            pathImage: question?['pathImage'],
            pathVideo: question?['pathVideo']),
      )
      .toList();
  List<Question> _questionsHard = dataQuestionsHard
      .map(
        (question) => Question(
            question: question['question'],
            options: question['options'],
            rightAnswer: question['rightAnswer'],
            pathImage: question?['pathImage'],
            pathVideo: question?['pathVideo']),
      )
      .toList();

  List<Question> choice(difficulty) {
    switch (difficulty) {
      case 'easy':
        {
          _questionsEasy.shuffle();
          _questionsEasy.toList().forEach((element) {
            element.options.shuffle();
          });
          return _questionsEasy;
        }

      case 'medium':
        {
          _questionsMedium.shuffle();
          _questionsMedium.toList().forEach((element) {
            element.options.shuffle();
          });
          return _questionsMedium;
        }

      case 'hard':
        {
          _questionsHard.shuffle();
          _questionsHard.toList().forEach((element) {
            element.options.shuffle();
          });
          return _questionsHard;
        }

      default:
        {
          return _questionsEasy;
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
