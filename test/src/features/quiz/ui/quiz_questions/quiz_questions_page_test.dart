/*import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jiu_jitsu_para_todos/app_module.dart';
import 'package:jiu_jitsu_para_todos/src/features/quiz/data/firebase_quiz_impl.dart';
import 'package:jiu_jitsu_para_todos/src/features/quiz/interector/interfaces/ifirebase_quiz.dart';
import 'package:jiu_jitsu_para_todos/src/features/quiz/interector/quiz_interector.dart';
import 'package:jiu_jitsu_para_todos/src/features/quiz/interector/quiz_state.dart';
import 'package:jiu_jitsu_para_todos/src/features/quiz/ui/quiz_questions/quiz_questions_page.dart';
import 'package:jiu_jitsu_para_todos/src/shared/l10n/locale_app.dart';
import 'package:jiu_jitsu_para_todos/src/shared/plugins/local_storage/interface/local_storage_interface.dart';
import 'package:jiu_jitsu_para_todos/src/shared/plugins/local_storage/local_storage_shared_preferrence.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MockQuizInteractor extends QuizInteractor {
  MockQuizInteractor({required super.firebaseQuiz});

  @override
  void loadQuestions(Difficult selectDifficult) {
    value = state;
  }

  static QuizState state = const QuizLoading();
}

class MockModule extends Module {
  @override
  void binds(i) {
    i.add<QuizInteractor>(MockQuizInteractor.new);
  }
}

void main() {
  testWidgets('Teste Quiz ', (WidgetTester tester) async {
    Modular.bindModule(AppModule());
    Modular.replaceInstance<QuizInteractor>(MockQuizInteractor.new);
    await tester.pumpWidget(
      ModularApp(
        module: MockModule(),
        child: MaterialApp(
          title: 'Jiu-jitsu para todos',
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en', 'Us'),
          theme: ThemeData(
            primaryColor: AppColors.primary,
            brightness: Brightness.dark,
            useMaterial3: true,
          ),
          home: const QuizQuestionsPage(difficulty: Difficult.easy),
        ),
      ),
    );

    expect(find.byKey(const Key('quizStateFailed')), findsNothing);
    expect(find.byKey(const Key('quizStateSuccess')), findsNothing);
    expect(find.byKey(const Key('quizStateLoading')), findsOneWidget);

    MockQuizInteractor.state = const QuizSuccess([]);
    Modular.get<QuizInteractor>().loadQuestions(Difficult.easy);
    await tester.pump();

    expect(find.byKey(const Key('quizStateFailed')), findsNothing);
    //expect(find.byKey(const Key('quizStateSuccess')), findsOneWidget);
    // expect(find.byKey(const Key('quizStateLoading')), findsNothing);
  });
}
*/