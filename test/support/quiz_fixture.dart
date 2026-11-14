import 'dart:async';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/interactor/quiz_state.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/interactor/answer_entity.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/interactor/question_entity.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/interactor/interfaces/ifirebase_quiz.dart';

class PendingQuiz implements IFirebaseQuiz {
  final response = Completer<QuizState>();
  Difficult? difficulty;
  String? language;
  @override
  Future<QuizState> loadQuestions(Difficult difficult, String languageCode) {
    difficulty = difficult;
    language = languageCode;
    return response.future;
  }
}

const question = QuestionEntity(
    question: 'Qual posição?',
    pathImage: null,
    pathVideo: null,
    options: [
      AnswerEntity(text: 'Guarda', isCorrect: true),
      AnswerEntity(text: 'Outra', isCorrect: false)
    ]);
