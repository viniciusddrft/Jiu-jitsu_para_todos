import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/data/firebase_quiz_impl.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/interector/interfaces/ifirebase_quiz.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/interector/quiz_interector.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/interector/quiz_state.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/ui/quiz_questions/quiz_questions_page.dart';
import 'package:jiu_jitsu_para_todos/src/shared/l10n/locale_app.dart';
import 'package:jiu_jitsu_para_todos/src/shared/plugins/local_storage/interface/local_storage_interface.dart';
import 'package:jiu_jitsu_para_todos/src/shared/plugins/local_storage/local_storage_shared_preferrence.dart';

class MockQuizInteractor extends QuizInteractor {
  MockQuizInteractor({required super.firebaseQuiz});

  @override
  void loadQuestions(Difficult selectDifficult) => value = newState;

  static QuizState newState = const QuizLoading();
}

class MockModule extends Module {
  @override
  void binds(i) {
    i.add<QuizInteractor>(MockQuizInteractor.new);
    i.add<IFirebaseQuiz>(FirebaseQuizImpl.new);
    i.addSingleton<ILocalStorage>(LocalStorageSharedPreferrence.new);
    i.addSingleton(LocaleInterector.new);
  }
}

void main() {
  group('Testes de stados do quiz -> ', () {
    testWidgets('loading ', (WidgetTester tester) async {
      await tester.pumpWidget(
        ModularApp(
          module: MockModule(),
          child: const MaterialApp(
            home: QuizQuestionsPage(difficulty: Difficult.easy),
          ),
        ),
      );

      expect(find.byKey(const Key('quizStateFailed')), findsNothing);
      expect(find.byKey(const Key('quizStateSuccess')), findsNothing);
      expect(find.byKey(const Key('quizStateLoading')), findsOneWidget);
    });

    testWidgets('failed ', (WidgetTester tester) async {
      MockQuizInteractor.newState = const QuizFailed();
      await tester.pumpWidget(
        ModularApp(
          module: MockModule(),
          child: const MaterialApp(
            home: QuizQuestionsPage(difficulty: Difficult.easy),
          ),
        ),
      );

      expect(find.byKey(const Key('quizStateFailed')), findsOneWidget);
      expect(find.byKey(const Key('quizStateSuccess')), findsNothing);
      expect(find.byKey(const Key('quizStateLoading')), findsNothing);
    });

    testWidgets('success ', (WidgetTester tester) async {
      MockQuizInteractor.newState = const QuizSuccess([]);
      await tester.pumpWidget(
        ModularApp(
          module: MockModule(),
          child: const MaterialApp(
            home: QuizQuestionsPage(difficulty: Difficult.easy),
          ),
        ),
      );

      expect(find.byKey(const Key('quizStateFailed')), findsNothing);
      expect(find.byKey(const Key('quizStateSuccess')), findsOneWidget);
      expect(find.byKey(const Key('quizStateLoading')), findsNothing);
    });
  });
}
