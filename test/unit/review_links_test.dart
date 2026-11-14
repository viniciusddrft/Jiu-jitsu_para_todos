import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jiu_jitsu_para_todos/src/shared/plugins/in_app_review/in_app_review_interactor.dart';
import 'package:jiu_jitsu_para_todos/src/shared/mixins/launch_link.dart';
import 'package:jiu_jitsu_para_todos/src/modules/credits/ui/credits.dart';
import 'package:material_ui/material_ui.dart';
import '../support/test_app.dart';

class LinkOpener with OpenLink {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MemoryStorage storage;
  late InAppReviewInteractor review;
  late List<MethodCall> requests, links;
  var available = true, fail = false, linkResult = true;
  setUp(() {
    storage = MemoryStorage();
    review = InAppReviewInteractor(storage);
    requests = [];
    links = [];
    available = true;
    fail = false;
    linkResult = true;
    final messenger =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    messenger.setMockMethodCallHandler(
        const MethodChannel('dev.britannio.in_app_review'), (call) async {
      requests.add(call);
      if (call.method == 'isAvailable') return available;
      if (fail) throw PlatformException(code: 'unavailable');
      return null;
    });
    messenger.setMockMethodCallHandler(
        const MethodChannel('plugins.flutter.io/url_launcher'), (call) async {
      links.add(call);
      return linkResult;
    });
  });
  test('avaliação exige três conclusões e pelo menos 75% de acertos', () async {
    expect(
        await review.registerQuizCompletionAndMaybeReview(scorePercentage: 1),
        isFalse);
    expect(
        await review.registerQuizCompletionAndMaybeReview(scorePercentage: 1),
        isFalse);
    expect(
        await review.registerQuizCompletionAndMaybeReview(scorePercentage: .74),
        isFalse);
    expect(requests, isEmpty);
    expect(storage.values['review_quiz_completions'], 3);
    expect(
        await review.registerQuizCompletionAndMaybeReview(scorePercentage: .75),
        isTrue);
    expect(requests.map((c) => c.method), ['isAvailable', 'requestReview']);
    expect(
        DateTime.tryParse(storage.values['review_last_request_iso'] as String),
        isNotNull);
    expect(
        await review.registerQuizCompletionAndMaybeReview(scorePercentage: 1),
        isFalse);
    expect(requests, hasLength(2));
  });
  for (final date in [
    DateTime.now().subtract(const Duration(days: 91)).toIso8601String(),
    'invalid'
  ]) {
    test('avaliação permite data antiga ou inválida: $date', () async {
      storage.values.addAll(
          {'review_quiz_completions': 2, 'review_last_request_iso': date});
      expect(
          await review.registerQuizCompletionAndMaybeReview(scorePercentage: 1),
          isTrue);
    });
  }
  test('avaliação indisponível ou com erro não salva cooldown', () async {
    storage.values['review_quiz_completions'] = 2;
    available = false;
    expect(
        await review.registerQuizCompletionAndMaybeReview(scorePercentage: 1),
        isFalse);
    available = true;
    fail = true;
    expect(
        await review.registerQuizCompletionAndMaybeReview(scorePercentage: 1),
        isFalse);
    expect(storage.values['review_last_request_iso'], isNull);
  });
  test('loja usa link externo quando avaliação está indisponível', () async {
    available = false;
    await review.openStoreListing();
    expect(links.single.arguments['url'],
        'https://play.google.com/store/apps/details?id=com.jiu_jitsu_para_todos');
    expect(links.single.arguments['useWebView'], isFalse);
  });
  test('link com falha chama onError quando fornecido', () async {
    linkResult = false;
    var errors = 0;
    await LinkOpener().openLink('https://example.com', onError: () => errors++);
    expect(errors, 1);
    await LinkOpener().openLink('https://example.com');
    expect(links, hasLength(2));
  });
  testWidgets('créditos abrem sites de atribuição', (tester) async {
    await mount(tester, const CreditsPage());
    expect(find.byKey(const Key('text flaticon')), findsOneWidget);
    await tester.tap(find.byKey(const Key('icon flaticon')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('icon flutter')));
    await tester.pump();
    expect(links.map((c) => c.arguments['url']),
        ['https://www.flaticon.com/', 'https://flutter.dev/']);
    await unmount(tester);
  });
}
