import 'package:flutter_modular/flutter_modular.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/interactor/interfaces/ifirebase_quiz.dart';
import '../../shared/plugins/sound/interface/sound_interface.dart';
import '../../shared/plugins/sound/sound_implements_just_audio.dart';
import 'data/firebase_quiz_impl.dart';
import 'interactor/quiz_interactor.dart';
import 'ui/quiz_menu/quiz_menu_page.dart';
import 'ui/quiz_questions/quiz_questions_page.dart';
import 'ui/quiz_result/quiz_result_page.dart';

class QuizModule extends Module {
  @override
  void binds(i) {
    i.add(QuizInteractor.new);
    i.add<SoundInterface>(JustAudio.new);
    i.add<IFirebaseQuiz>(FirebaseQuizImpl.new);
  }

  @override
  void routes(r) {
    r.child('/menu',
        child: (context) => const QuizMenuPage(),
        transition: TransitionType.rightToLeft);
    r.child('/questions',
        child: (context) =>
            QuizQuestionsPage(difficulty: r.args.data as Difficult),
        transition: TransitionType.rightToLeft);
    r.child('/result',
        child: (context) => QuizResultPage(
              difficult: r.args.data['difficult'],
              score: r.args.data['score'],
              totalQuestions: r.args.data['totalQuestions'],
            ),
        transition: TransitionType.downToUp);
  }
}
