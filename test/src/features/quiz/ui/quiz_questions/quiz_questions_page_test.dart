import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jiu_jitsu_para_todos/app_module.dart';
import 'package:jiu_jitsu_para_todos/src/features/quiz/interector/interfaces/ifirebase_quiz.dart';
import 'package:jiu_jitsu_para_todos/src/features/quiz/ui/quiz_questions/quiz_questions_page.dart';
import 'package:jiu_jitsu_para_todos/src/shared/components/button_menu.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  testWidgets('Teste Quiz ', (WidgetTester tester) async {
    await tester.pumpWidget(
      ModularApp(
        module: AppModule(),
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
          home: const QuizQuestionsPage(difficulty: Difficult.hard),
        ),
      ),
    );

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(ButtonMenu), findsNWidgets(5));
  });
}
