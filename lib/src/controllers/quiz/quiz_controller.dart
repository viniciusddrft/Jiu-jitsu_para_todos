import 'package:jiu_jitsu_para_todos/src/models/quiz/quiz_questions_model.dart';

class ControllerQuiz {
  int numberquestions = 0;

  List<Question> _questionseasy = dataquestionseasy
      .map(
        (question) => Question(
            question: question['question'],
            options: question['options'],
            rightanswer: question['rightanswer'],
            pathImage: question['pathImage'],
            pathVideo: question['pathVideo']),
      )
      .toList();
  List<Question> _questionsmedium = dataquestionsmedium
      .map(
        (question) => Question(
            question: question['question'],
            options: question['options'],
            rightanswer: question['rightanswer'],
            pathImage: question['pathImage'],
            pathVideo: question['pathVideo']),
      )
      .toList();
  List<Question> _questionshard = dataquestionshard
      .map(
        (question) => Question(
            question: question['question'],
            options: question['options'],
            rightanswer: question['rightanswer'],
            pathImage: question['pathImage'],
            pathVideo: question['pathVideo']),
      )
      .toList();

  List<Question> choice(difficulty) {
    switch (difficulty) {
      case 'easy':
        {
          _questionseasy.shuffle();
          _questionseasy.toList().forEach((element) {
            element.options.shuffle();
          });
          return _questionseasy;
        }
        break;
      case 'medium':
        {
          _questionsmedium.shuffle();
          _questionsmedium.toList().forEach((element) {
            element.options.shuffle();
          });
          return _questionsmedium;
        }
        break;
      case 'hard':
        {
          _questionshard.shuffle();
          _questionshard.toList().forEach((element) {
            element.options.shuffle();
          });
          return _questionshard;
        }
        break;
      default:
        {
          return _questionseasy;
        }
        break;
    }
  }

  String textquestionreturn(myquestions) =>
      myquestions.toList()[numberquestions].question;

  String returntextanswerA(myquestions) =>
      myquestions.toList()[numberquestions].options[0];

  String returntextanswerB(myquestions) =>
      myquestions.toList()[numberquestions].options[1];

  String returntextanswerC(myquestions) =>
      myquestions.toList()[numberquestions].options[2];

  String returntextanswerD(myquestions) =>
      myquestions.toList()[numberquestions].options[3];

  bool checkanswer(String answer, myquestions) =>
      answer == myquestions.toList()[numberquestions].rightanswer;

  String returnPathImage(myquestions) =>
      myquestions.toList()[numberquestions].pathImage;

  String returnPathVideo(myquestions) =>
      myquestions.toList()[numberquestions].pathVideo;
}
