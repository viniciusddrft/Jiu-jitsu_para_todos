import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/interactor/interfaces/ifirebase_quiz.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/interactor/quiz_interactor.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/interactor/quiz_state.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/ui/quiz_questions/quiz_questions_page.dart';
import 'package:jiu_jitsu_para_todos/src/shared/l10n/locale_app.dart';
import 'package:jiu_jitsu_para_todos/src/shared/plugins/local_storage/interface/local_storage_interface.dart';
import 'package:jiu_jitsu_para_todos/src/shared/plugins/sound/interface/sound_interface.dart';
import 'package:jiu_jitsu_para_todos/src/shared/l10n/app_localizations.dart';
import 'package:material_ui/material_ui.dart';

class MockQuizInteractor extends QuizInteractor {
  MockQuizInteractor({required super.firebaseQuiz});

  @override
  void loadQuestions(Difficult selectDifficult) => value = newState;

  static QuizState newState = const QuizLoading();
}

class FakeFirebaseQuiz implements IFirebaseQuiz {
  @override
  Future<QuizState> loadQuestions(Difficult difficult, String languageCode) =>
      Future.value(const QuizLoading());
}

class FakeLocalStorage implements ILocalStorage {
  @override
  Future<T?> getValue<T>(String key) async => null;
  @override
  void saveValue<T>(String key, T value) {}
  @override
  void remove(String key) {}
}

class FakeSound implements SoundInterface {
  @override
  void dispose() {}
  @override
  Future<void> play(String soundPath) async {}
  @override
  void stop() {}
  @override
  void pause() {}
}

final mockModule = createModule(
  register: (c) => c
    ..add<QuizInteractor>(MockQuizInteractor.new)
    ..add<IFirebaseQuiz>(FakeFirebaseQuiz.new)
    ..add<SoundInterface>(FakeSound.new)
    ..addSingleton<ILocalStorage>(FakeLocalStorage.new)
    ..addSingleton(LocaleInteractor.new),
);

Widget app() => ModularApp(
      module: mockModule,
      child: const MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          ...GlobalMaterialLocalizations.delegates,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: QuizQuestionsPage(difficulty: Difficult.easy),
      ),
    );

void main() {
  group('Testes de stados do quiz -> ', () {
    testWidgets('loading ', (WidgetTester tester) async {
      MockQuizInteractor.newState = const QuizLoading();
      await tester.pumpWidget(app());

      expect(find.byKey(const Key('quizStateFailed')), findsNothing);
      expect(find.byKey(const Key('quizStateSuccess')), findsNothing);
      expect(find.byKey(const Key('quizStateLoading')), findsOneWidget);
    });

    testWidgets('failed ', (WidgetTester tester) async {
      MockQuizInteractor.newState = const QuizFailed();
      await tester.pumpWidget(app());

      expect(find.byKey(const Key('quizStateFailed')), findsOneWidget);
      expect(find.byKey(const Key('quizStateSuccess')), findsNothing);
      expect(find.byKey(const Key('quizStateLoading')), findsNothing);
    });

    testWidgets('success ', (WidgetTester tester) async {
      MockQuizInteractor.newState = const QuizSuccess([]);
      await tester.pumpWidget(app());

      expect(find.byKey(const Key('quizStateFailed')), findsNothing);
      expect(find.byKey(const Key('quizStateSuccess')), findsOneWidget);
      expect(find.byKey(const Key('quizStateLoading')), findsNothing);
    });
  });
}
