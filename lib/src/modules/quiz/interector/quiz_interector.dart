import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/interector/quiz_state.dart';
import 'package:jiu_jitsu_para_todos/src/shared/l10n/locale_app.dart';

import '../../../shared/plugins/sound/interface/sound_interface.dart';
import 'answer_entity.dart';
import 'interfaces/ifirebase_quiz.dart';

class QuizInteractor extends ValueNotifier<QuizState> {
  QuizInteractor({required this.firebaseQuiz}) : super(const QuizLoading());

  final IFirebaseQuiz firebaseQuiz;
  final _localeAppNotifier = Modular.get<LocaleInterector>();
  late final Difficult difficult;
  final _soundInterface = Modular.get<SoundInterface>();

  int score = 0;
  int numberQuestion = 0;
  int totalQuestions = 0;

  void playSoundRightAnswer() =>
      _soundInterface.play('assets/music/right_answer.mp3');

  void playSoundWrongAnswer() =>
      _soundInterface.play('assets/music/wrong_answer.mp3');

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
    notifyListeners();
  }
}
