import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/interactor/interfaces/ifirebase_quiz.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/interactor/answer_entity.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/ui/quiz_questions/components/button_quiz_widget.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/ui/quiz_result/quiz_result_page.dart';
import 'package:jiu_jitsu_para_todos/src/modules/settings/ui/settings_page.dart';
import 'package:jiu_jitsu_para_todos/src/modules/settings/interactor/settings_interactor.dart';
import 'package:jiu_jitsu_para_todos/src/shared/l10n/locale_app.dart';
import 'package:jiu_jitsu_para_todos/src/shared/l10n/app_localizations.dart';
import 'package:jiu_jitsu_para_todos/src/shared/plugins/admob/admob_interactor.dart';
import 'package:jiu_jitsu_para_todos/src/shared/plugins/in_app_review/in_app_review_interactor.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';
import '../support/test_app.dart';

void main() {
  for (final correct in [true, false]) {
    testWidgets('resposta $correct exibe feedback antes de avançar',
        (tester) async {
      final answer = AnswerEntity(text: 'Resposta', isCorrect: correct);
      AnswerEntity? selected;
      await mount(
          tester,
          Scaffold(
              body: ButtonQuizQuestionsWidget(
                  answerEntity: answer, onPressedButton: (a) => selected = a)));
      await tester.tap(find.text('Resposta'));
      await tester.pump();
      expect(find.byIcon(correct ? Icons.check_rounded : Icons.close_rounded),
          findsOneWidget);
      final material = tester.widget<Material>(find
          .ancestor(of: find.text('Resposta'), matching: find.byType(Material))
          .first);
      expect(material.color,
          correct ? AppColors.successSurface : AppColors.errorSurface);
      expect(selected, isNull);
      await tester.pump(const Duration(milliseconds: 500));
      expect(selected, same(answer));
      await unmount(tester);
    });
  }
  for (final scenario in [
    (
      4,
      Difficult.easy,
      '100%',
      (AppLocalizations l) => l.text_message_quiz_very_well
    ),
    (
      3,
      Difficult.medium,
      '75%',
      (AppLocalizations l) => l.text_message_quiz_almost
    ),
    (1, Difficult.hard, '25%', (AppLocalizations l) => l.text_message_quiz_sad)
  ]) {
    for (final handled in [true, false]) {
      testWidgets(
          'resultado ${scenario.$3} review=$handled decide anúncio após animação',
          (tester) async {
        final ads = RecordingAds();
        final review = RecordingReview()..handled = handled;
        await mount(
            tester,
            QuizResultPage(
                score: scenario.$1, difficult: scenario.$2, totalQuestions: 4),
            register: (c) => c
              ..addInstance<AdmobInteractor>(ads)
              ..addInstance<InAppReviewInteractor>(review));
        expect(find.text(scenario.$3), findsOneWidget);
        final l =
            AppLocalizations.of(tester.element(find.byType(QuizResultPage)))!;
        expect(find.text(scenario.$4(l).toUpperCase()), findsOneWidget);
        expect(find.text(l.quiz_correct_count(scenario.$1, 4)), findsOneWidget);
        expect(ads.shows, 0);
        await tester.pump(const Duration(milliseconds: 1));
        await tester.pump(const Duration(seconds: 2));
        await tester.pump(const Duration(seconds: 1));
        expect(review.scores, [scenario.$1 / 4]);
        expect(ads.shows, handled ? 0 : 1);
        await unmount(tester);
      });
    }
  }
  testWidgets('resultado desmontado não solicita review nem anúncio',
      (tester) async {
    final ads = RecordingAds();
    final review = RecordingReview();
    await mount(
        tester,
        const QuizResultPage(
            score: 4, difficult: Difficult.easy, totalQuestions: 4),
        register: (c) => c
          ..addInstance<AdmobInteractor>(ads)
          ..addInstance<InAppReviewInteractor>(review));
    await tester.pump(const Duration(milliseconds: 1));
    await tester.pump(const Duration(seconds: 2));
    await unmount(tester);
    await tester.pump(const Duration(seconds: 1));
    expect(review.scores, isEmpty);
    expect(ads.shows, 0);
  });
  testWidgets('configurações mostram versão, trocam idioma e abrem avaliação',
      (tester) async {
    final storage = MemoryStorage();
    final locale = LocaleInteractor(storage);
    final review = RecordingReview();
    await mount(tester, const SettingsPage(appVersion: '3.3.3'),
        register: (c) => c
          ..addInstance<LocaleInteractor>(locale)
          ..add(SettingsInteractor.new)
          ..addInstance<InAppReviewInteractor>(review));
    final l = AppLocalizations.of(tester.element(find.byType(SettingsPage)))!;
    expect(find.text('${l.text_version} 3.3.3'), findsOneWidget);
    await tester.tap(find.text(l.text_brazilian_portuguese));
    await tester.pumpAndSettle();
    expect(locale.value, const Locale('pt', 'BR'));
    expect(storage.values['locale'], 'pt_BR');
    await tester.tap(find.text(l.text_english_united_states));
    await tester.pumpAndSettle();
    expect(locale.value, const Locale('en', 'US'));
    expect(storage.values['locale'], 'en_US');
    await tester.tap(find.text(l.text_rate_the_app));
    await tester.pump();
    expect(review.storeRequests, 1);
    await unmount(tester);
  });
}
