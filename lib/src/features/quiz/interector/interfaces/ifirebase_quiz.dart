import 'package:jiu_jitsu_para_todos/src/features/quiz/interector/quiz_state.dart';

enum Difficult {
  easy('quiz_easy'),
  medium('quiz_medium'),
  hard('quiz_hard');

  const Difficult(this.nameCollection);

  final String nameCollection;
}

abstract interface class IFirebaseQuiz {
  Future<QuizState> loadQuestions(Difficult difficult, String languageCode);
}
