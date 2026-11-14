import 'package:flutter_modular/flutter_modular.dart';
import '../../shared/plugins/sound/interface/sound_interface.dart';
import '../../shared/plugins/sound/sound_implements_just_audio.dart';
import '../../shared/transitions/app_transitions.dart';
import 'data/firebase_quiz_impl.dart';
import 'interactor/interfaces/ifirebase_quiz.dart';
import 'interactor/quiz_interactor.dart';
import 'ui/quiz_menu/quiz_menu_page.dart';
import 'ui/quiz_questions/quiz_questions_page.dart';
import 'ui/quiz_result/quiz_result_page.dart';

final quizModule = createModule(
  path: '/quiz',
  register: (c) => c
    ..add(QuizInteractor.new)
    ..add<SoundInterface>(JustAudio.new)
    ..add<IFirebaseQuiz>(FirebaseQuizImpl.new)
    ..route('/menu',
        child: (context, state) => const QuizMenuPage(),
        transition: AppTransitions.rightToLeft)
    ..route('/questions',
        child: (context, state) =>
            QuizQuestionsPage(difficulty: state.arguments as Difficult),
        transition: AppTransitions.rightToLeft)
    ..route('/result', child: (context, state) {
      final args = state.arguments as Map<String, dynamic>;
      return QuizResultPage(
        difficult: args['difficult'],
        score: args['score'],
        totalQuestions: args['totalQuestions'],
      );
    }, transition: AppTransitions.downToUp),
);
