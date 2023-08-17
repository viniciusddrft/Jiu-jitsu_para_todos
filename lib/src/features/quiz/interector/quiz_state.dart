import 'package:jiu_jitsu_para_todos/src/features/quiz/interector/question_entity.dart';

sealed class QuizState {}

final class QuizFailed implements QuizState {}

final class QuizSuccess implements QuizState {
  final List<QuestionEntity> questions;

  const QuizSuccess(this.questions);
}

final class QuizLoading implements QuizState {}
