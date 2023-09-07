import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jiu_jitsu_para_todos/src/features/quiz/interector/quiz_state.dart';
import 'package:jiu_jitsu_para_todos/src/shared/l10n/locale_app.dart';

import 'answer_entity.dart';
import 'interfaces/ifirebase_quiz.dart';

class QuizInteractor extends ValueNotifier<QuizState> {
  QuizInteractor({required this.firebaseQuiz}) : super(const QuizLoading());

  final IFirebaseQuiz firebaseQuiz;
  final _localeAppNotifier = Modular.get<LocaleInterector>();
  late final Difficult difficult;

  int score = 0;
  int numberQuestion = 0;
  int totalQuestions = 0;

  void loadQuestions(Difficult selectDifficult) async {
    value = const QuizLoading();
    difficult = selectDifficult;
    final newState = await firebaseQuiz.loadQuestions(
        selectDifficult, '_${_localeAppNotifier.value.languageCode}');

    if (newState is QuizSuccess) {
      totalQuestions = newState.questions.length;
    }
    value = newState;
  }

  void onPressed(AnswerEntity answerEntity) {
    numberQuestion++;
    if (answerEntity.isCorrect) {
      score++;
    }
  }
}
