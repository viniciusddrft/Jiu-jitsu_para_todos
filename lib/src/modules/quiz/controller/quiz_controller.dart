import 'package:flutter/material.dart';

import 'package:jiu_jitsu_para_todos/src/shared/repositoryes/interface/repository_api_interface.dart';

import '../../../shared/models/quiz/questions_model.dart';
import '../../../shared/repositoryes/repository_api.dart';

class ControllerQuiz extends ChangeNotifier {
  final RepositoryApi _repositoryApi = RepositoryApi();

  int _score = 0;
  int indexCurrentQuestion = 0;

  bool isButtonDisabled = false;

  Color colorButtonA = Colors.white;
  Color colorButtonB = Colors.white;
  Color colorButtonC = Colors.white;
  Color colorButtonD = Colors.white;

  IconData? iconButtonA, iconButtonB, iconButtonC, iconButtonD;

  Color? colorIconButtonA, colorIconButtonB, colorIconButtonC, colorIconButtonD;

  int get counterQuestions => indexCurrentQuestion + 1;

  int get score => _score;

  void addScore() => _score++;

  void nextQuestion() {
    indexCurrentQuestion++;
    notifyListeners();
  }

  Future<List<QuestionModel>> choice(
      {required String difficulty, required Locale locale}) async {
    if (difficulty == 'easy') {
      if (locale == const Locale('en', 'US')) {
        return _repositoryApi.getQuestions(ApiRequests.quizEnglishWhiteBelt);
      } else if (locale == const Locale('pt', 'BR')) {
        return _repositoryApi.getQuestions(ApiRequests.quizPortugueseWhiteBelt);
      } else {
        throw Exception('Error in Locale app');
      }
    } else if (difficulty == 'medium') {
      if (locale == const Locale('en', 'US')) {
        return _repositoryApi.getQuestions(ApiRequests.quizEnglishBlueBelt);
      } else if (locale == const Locale('pt', 'BR')) {
        return _repositoryApi.getQuestions(ApiRequests.quizPortugueseBlueBelt);
      } else {
        throw Exception('Error in Locale app');
      }
    } else {
      if (locale == const Locale('en', 'US')) {
        return _repositoryApi.getQuestions(ApiRequests.quizEnglishBlack);
      } else if (locale == const Locale('pt', 'BR')) {
        return _repositoryApi.getQuestions(ApiRequests.quizPortugueseBlackBelt);
      } else {
        throw Exception('Error in Locale app');
      }
    }
  }

  void paintButtonA({required bool isRight}) {
    if (isRight) {
      iconButtonA = Icons.done;
      colorButtonA = Colors.green;
      colorIconButtonA = Colors.green;
    } else {
      iconButtonA = Icons.close;
      colorButtonA = Colors.red;
      colorIconButtonA = Colors.red;
    }
  }

  void paintButtonB({required bool isRight}) {
    if (isRight) {
      iconButtonB = Icons.done;
      colorButtonB = Colors.green;
      colorIconButtonB = Colors.green;
    } else {
      iconButtonB = Icons.close;
      colorButtonB = Colors.red;
      colorIconButtonB = Colors.red;
    }
  }

  void paintButtonC({required bool isRight}) {
    if (isRight) {
      iconButtonC = Icons.done;
      colorButtonC = Colors.green;
      colorIconButtonC = Colors.green;
    } else {
      iconButtonC = Icons.close;
      colorButtonC = Colors.red;
      colorIconButtonC = Colors.red;
    }
  }

  void paintButtonD({required bool isRight}) {
    if (isRight) {
      iconButtonD = Icons.done;
      colorButtonD = Colors.green;
      colorIconButtonD = Colors.green;
    } else {
      iconButtonD = Icons.close;
      colorButtonD = Colors.red;
      colorIconButtonD = Colors.red;
    }
  }

  void cleanButtons() {
    isButtonDisabled = false;
    colorButtonA = Colors.white;
    colorButtonB = Colors.white;
    colorButtonC = Colors.white;
    colorButtonD = Colors.white;
    iconButtonA = null;
    iconButtonB = null;
    iconButtonC = null;
    iconButtonD = null;
  }

  String textQuestionReturn(List<QuestionModel> myQuestions) =>
      myQuestions.toList()[indexCurrentQuestion].question;

  String returnTextAnswerA(List<QuestionModel> myQuestions) =>
      myQuestions.toList()[indexCurrentQuestion].options[0];

  String returnTextAnswerB(List<QuestionModel> myQuestions) =>
      myQuestions.toList()[indexCurrentQuestion].options[1];

  String returnTextAnswerC(List<QuestionModel> myQuestions) =>
      myQuestions.toList()[indexCurrentQuestion].options[2];

  String returnTextAnswerD(List<QuestionModel> myQuestions) =>
      myQuestions.toList()[indexCurrentQuestion].options[3];

  bool checkAnswer(String answer, List<QuestionModel> myQuestions) {
    isButtonDisabled = true;
    notifyListeners();
    return answer == myQuestions.toList()[indexCurrentQuestion].rightAnswer;
  }

  String? returnPathImage(List<QuestionModel> myQuestions) =>
      myQuestions.toList()[indexCurrentQuestion].pathImage;

  String? returnPathVideo(List<QuestionModel> myQuestions) =>
      myQuestions.toList()[indexCurrentQuestion].pathVideo;

  bool existImage(List<QuestionModel> myQuestions) =>
      myQuestions.toList()[indexCurrentQuestion].pathImage != null;

  bool existVideo(List<QuestionModel> myQuestions) =>
      myQuestions.toList()[indexCurrentQuestion].pathVideo != null;
}
