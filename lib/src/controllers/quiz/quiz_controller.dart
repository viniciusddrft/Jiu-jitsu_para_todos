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
    if (difficulty == 'easy') {
      _questionseasy.shuffle();
      _questionseasy.toList().forEach((element) {
        element.options.shuffle();
      });
      return _questionseasy;
    } else if (difficulty == 'medium') {
      _questionsmedium.shuffle();
      _questionsmedium.toList().forEach((element) {
        element.options.shuffle();
      });
      return _questionsmedium;
    } else if (difficulty == 'hard') {
      _questionshard.shuffle();
      _questionshard.toList().forEach((element) {
        element.options.shuffle();
      });
      return _questionshard;
    }
    _questionseasy.shuffle();
    return _questionseasy;
  }

  String textquestionreturn(myquestions) {
    return myquestions.toList()[numberquestions].question;
  }

  String returntextanswerA(myquestions) {
    return myquestions.toList()[numberquestions].options[0];
  }

  String returntextanswerB(myquestions) {
    return myquestions.toList()[numberquestions].options[1];
  }

  String returntextanswerC(myquestions) {
    return myquestions.toList()[numberquestions].options[2];
  }

  String returntextanswerD(myquestions) {
    return myquestions.toList()[numberquestions].options[3];
  }

  bool checkanswer(String answer, myquestions) {
    if (answer == myquestions.toList()[numberquestions].rightanswer) {
      return true;
    } else {
      return false;
    }
  }

  String returnPathImage(myquestions) {
    return myquestions.toList()[numberquestions].pathImage;
  }

  String returnPathVideo(myquestions) {
    return myquestions.toList()[numberquestions].pathVideo;
  }
}
