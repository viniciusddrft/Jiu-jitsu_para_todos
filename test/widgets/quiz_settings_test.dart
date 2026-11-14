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
      expect(find.byIcon(correct ? Icons.done : Icons.close), findsOneWidget);
      final text = tester.widget<Text>(find.text('Resposta'));
      expect(text.style!.color, correct ? Colors.green : Colors.red);
      expect(selected, isNull);
      await tester.pump(const Duration(milliseconds: 500));
      expect(selected, same(answer));
      await unmount(tester);
    });
  }
  for (final scenario in [
    (4, Difficult.easy, '100%', 'victory.png'),
    (3, Difficult.medium, '75%', 'reading-book.png'),
    (1, Difficult.hard, '25%', 'sad.png')
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
        final asset =
            tester.widget<Image>(find.byType(Image).first).image as AssetImage;
        expect(asset.assetName, endsWith(scenario.$4));
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
  testWidgets(
      'configurações mostram versão, trocam idioma, cancelam e abrem avaliação',
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
    final language =
        find.widgetWithText(OutlinedButton, l.button_language_settings_page);
    await tester.tap(language);
    await tester.pumpAndSettle();
    await tester.tap(find.text(l.text_brazilian_portuguese));
    await tester.pumpAndSettle();
    expect(locale.value, const Locale('pt', 'BR'));
    expect(storage.values['locale'], 'pt_BR');
    await tester.tap(language);
    await tester.pumpAndSettle();
    await tester.tap(find.text(l.text_cancel));
    await tester.pumpAndSettle();
    expect(locale.value, const Locale('pt', 'BR'));
    await tester.tap(find.text(l.text_rate_the_app));
    await tester.pump();
    expect(review.storeRequests, 1);
    await unmount(tester);
  });
}
