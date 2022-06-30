import 'package:flutter/widgets.dart';

import 'package:jiu_jitsu_para_todos/src/shared/repositories/interface/repository_api_interface.dart';

import '../../../../core/locale/locale_app.dart';
import '../../../shared/models/quiz/questions_model.dart';
import '../../../shared/repositories/repository_api.dart';

class ControllerQuiz {
  final RepositoryApi _repositoryApi = RepositoryApi();

  int numberOfQuestions = 0;
  int score = 0;

  late List<QuestionModel> myQuestions;

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
            throw Exception('Error in Locale app');
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
            throw Exception('Error in Locale app');
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
            throw Exception('Error in Locale app');
          }
          break;
        }
    }
  }

  String textQuestionReturn() =>
      myQuestions.toList()[numberOfQuestions].question;

  String returnTextAnswerA() =>
      myQuestions.toList()[numberOfQuestions].options[0];

  String returnTextAnswerB() =>
      myQuestions.toList()[numberOfQuestions].options[1];

  String returnTextAnswerC() =>
      myQuestions.toList()[numberOfQuestions].options[2];

  String returnTextAnswerD() =>
      myQuestions.toList()[numberOfQuestions].options[3];

  bool checkAnswer(String answer) =>
      answer == myQuestions.toList()[numberOfQuestions].rightAnswer;

  String? returnPathImage() =>
      myQuestions.toList()[numberOfQuestions].pathImage;

  String? returnPathVideo() =>
      myQuestions.toList()[numberOfQuestions].pathVideo;

  bool existImage() =>
      myQuestions.toList()[numberOfQuestions].pathImage != null;

  bool existVideo() =>
      myQuestions.toList()[numberOfQuestions].pathVideo != null;
}
