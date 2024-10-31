import 'package:jiu_jitsu_para_todos/src/modules/quiz/interactor/question_entity.dart';

sealed class QuizState {}

final class QuizFailed implements QuizState {
  const QuizFailed();
}

final class QuizSuccess implements QuizState {
  final List<QuestionEntity> questions;

  const QuizSuccess(this.questions);
}

final class QuizLoading implements QuizState {
  const QuizLoading();
}
