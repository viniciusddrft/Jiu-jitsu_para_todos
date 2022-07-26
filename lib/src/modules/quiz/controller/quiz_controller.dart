import 'package:flutter/material.dart';

import 'package:jiu_jitsu_para_todos/src/shared/repositories/interface/repository_api_interface.dart';

import '../../../../core/locale/locale_app.dart';
import '../../../shared/models/quiz/questions_model.dart';
import '../../../shared/repositories/repository_api.dart';

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

  int get totalNumberOfQuestions => myQuestions.length;

  int get score => _score;

  late final List<QuestionModel> myQuestions;

  void addScore() => _score++;

  void nextQuestion() {
    indexCurrentQuestion++;
    notifyListeners();
  }

  Never _errorInLocale() {
    throw Exception('Error in Locale app');
  }

  Future<void> choice({required String difficulty}) async {
    switch (difficulty) {
      case 'easy':
        {
          if (LocaleApp.localeApp.value == const Locale('en', 'US')) {
            myQuestions = await _repositoryApi
                .getQuestions(ApiRequests.quizEnglishWhiteBelt);
          } else if (LocaleApp.localeApp.value == const Locale('pt', 'BR')) {
            myQuestions = await _repositoryApi
                .getQuestions(ApiRequests.quizPortugueseWhiteBelt);
          } else {
            _errorInLocale();
          }

          break;
        }

      case 'medium':
        {
          if (LocaleApp.localeApp.value == const Locale('en', 'US')) {
            myQuestions = await _repositoryApi
                .getQuestions(ApiRequests.quizEnglishBlueBelt);
          } else if (LocaleApp.localeApp.value == const Locale('pt', 'BR')) {
            myQuestions = await _repositoryApi
                .getQuestions(ApiRequests.quizPortugueseBlueBelt);
          } else {
            _errorInLocale();
          }

          break;
        }

      case 'hard':
        {
          if (LocaleApp.localeApp.value == const Locale('en', 'US')) {
            myQuestions = await _repositoryApi
                .getQuestions(ApiRequests.quizPortugueseBlackBelt);
          } else if (LocaleApp.localeApp.value == const Locale('pt', 'BR')) {
            myQuestions = await _repositoryApi
                .getQuestions(ApiRequests.quizPortugueseBlackBelt);
          } else {
            _errorInLocale();
          }
          break;
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

  String textQuestionReturn() =>
      myQuestions.toList()[indexCurrentQuestion].question;

  String returnTextAnswerA() =>
      myQuestions.toList()[indexCurrentQuestion].options[0];

  String returnTextAnswerB() =>
      myQuestions.toList()[indexCurrentQuestion].options[1];

  String returnTextAnswerC() =>
      myQuestions.toList()[indexCurrentQuestion].options[2];

  String returnTextAnswerD() =>
      myQuestions.toList()[indexCurrentQuestion].options[3];

  bool checkAnswer(String answer) {
    isButtonDisabled = true;
    notifyListeners();
    return answer == myQuestions.toList()[indexCurrentQuestion].rightAnswer;
  }

  String? returnPathImage() =>
      myQuestions.toList()[indexCurrentQuestion].pathImage;

  String? returnPathVideo() =>
      myQuestions.toList()[indexCurrentQuestion].pathVideo;

  bool existImage() =>
      myQuestions.toList()[indexCurrentQuestion].pathImage != null;

  bool existVideo() =>
      myQuestions.toList()[indexCurrentQuestion].pathVideo != null;
}
