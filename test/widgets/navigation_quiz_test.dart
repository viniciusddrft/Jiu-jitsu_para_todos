import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:jiu_jitsu_para_todos/src/modules/home/ui/home_page.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/ui/quiz_menu/quiz_menu_page.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/ui/quiz_questions/quiz_questions_page.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/interactor/quiz_interactor.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/interactor/quiz_state.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/interactor/interfaces/ifirebase_quiz.dart';
import 'package:jiu_jitsu_para_todos/src/modules/historyofjiujitsu/ui/historyofjiujitsumenu/history_of_jiu_jitsu_page.dart';
import 'package:jiu_jitsu_para_todos/src/modules/rules/ui/rulesmenu/rules_view.dart';
import 'package:jiu_jitsu_para_todos/src/shared/plugins/analytics/analytics_interactor.dart';
import 'package:jiu_jitsu_para_todos/src/shared/plugins/sound/interface/sound_interface.dart';
import 'package:jiu_jitsu_para_todos/src/shared/l10n/locale_app.dart';
import 'package:jiu_jitsu_para_todos/src/shared/transitions/app_transitions.dart';
import '../support/test_app.dart';
import '../support/quiz_fixture.dart';

void main() {
  // (página, [(chave do item tocável, rota esperada)])
  final menus = <(Widget, List<(String, String)>)>[
    (
      const HomePage(),
      [
        ('home_history', '/historyojiujitsu/historyojiujitsu'),
        ('home_rules', '/rules/rules'),
        ('quizCard', '/quiz/menu'),
        ('home_fightmarker', '/fightmaker/fightmaker'),
        ('home_wallpapers', '/wallpaper/wallpapers'),
      ]
    ),
    (
      const QuizMenuPage(),
      [
        ('quizLevel_easy', '/quiz/questions'),
        ('quizLevel_medium', '/quiz/questions'),
        ('quizLevel_hard', '/quiz/questions'),
      ]
    ),
    (
      const RulesPage(),
      [
        ('rules_basic', '/rules/basicrules'),
        ('rules_cbjj', '/rules/cbjjrules'),
      ]
    ),
    (
      const HistoryOfJiuJitsuPage(),
      [
        ('history_0', '/historyojiujitsu/jiujitsuinjapan'),
        ('history_1', '/historyojiujitsu/jiujitsuinindia'),
        ('history_2', '/historyojiujitsu/jiujitsuinbrazil'),
      ]
    ),
  ];
  for (final (page, items) in menus) {
    final routes = [for (final (_, route) in items) route];
    for (var index = 0; index < items.length; index++) {
      testWidgets(
          '${page.runtimeType} opção $index navega com argumentos corretos',
          (tester) async {
        final analytics = RecordingAnalytics();
        Object? arguments;
        await mountRouter(tester, createModule(register: (c) {
          c.addInstance<AnalyticsInteractor>(analytics);
          c.route('/', child: (_, __) => page);
          for (final route in routes.toSet()) {
            c.route(route, child: (_, state) {
              arguments = state.arguments;
              return Scaffold(body: Text(state.uri.path));
            }, transition: AppTransitions.rightToLeft);
          }
        }));
        final button = find.byKey(Key(items[index].$1));
        await tester.pumpAndSettle();
        await tester.ensureVisible(button);
        await tester.pumpAndSettle();
        await tester.tap(button);
        await tester.pumpAndSettle();
        expect(find.text(routes[index]), findsOneWidget);
        if (page is HomePage) {
          expect(analytics.features, [
            ['history', 'rules', 'quiz', 'fightmarker', 'wallpaper'][index]
          ]);
        }
        if (page is QuizMenuPage) expect(arguments, Difficult.values[index]);
        await unmount(tester);
      });
    }
  }
  testWidgets('home abre configurações e registra acesso', (tester) async {
    final analytics = RecordingAnalytics();
    await mountRouter(
        tester,
        createModule(
            register: (c) => c
              ..addInstance<AnalyticsInteractor>(analytics)
              ..route('/', child: (_, __) => const HomePage())
              ..route('/settings/settings',
                  child: (_, __) => const Text('settings destination'))));
    await tester.tap(find.byKey(const Key('settingsButton')));
    await tester.pumpAndSettle();
    expect(analytics.features, ['settings']);
    expect(find.text('settings destination'), findsOneWidget);
    await unmount(tester);
  });
  for (final difficulty in Difficult.values) {
    testWidgets(
        'quiz $difficulty responde, expira e envia pontuação ao resultado',
        (tester) async {
      final repository = PendingQuiz();
      final sound = RecordingSound();
      QuizInteractor? quiz;
      Map<String, dynamic>? result;
      await mountRouter(
          tester,
          createModule(
              register: (c) => c
                ..addInstance<LocaleInteractor>(
                    LocaleInteractor(MemoryStorage()))
                ..addInstance<SoundInterface>(sound)
                ..add<QuizInteractor>(
                    () => quiz = QuizInteractor(firebaseQuiz: repository))
                ..route('/',
                    child: (_, __) => QuizQuestionsPage(difficulty: difficulty))
                ..route('/quiz/result', child: (_, state) {
                  result = state.arguments as Map<String, dynamic>;
                  return const Scaffold(body: Text('Resultado final'));
                }, transition: AppTransitions.downToUp)));
      expect(find.byKey(const Key('quizStateLoading')), findsOneWidget);
      repository.response.complete(const QuizSuccess([question, question]));
      await tester.pump();
      await tester.pump();
      expect(find.text('QUAL POSIÇÃO?'), findsWidgets);
      await tester.tap(find.text('Guarda').first);
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump(const Duration(seconds: 1));
      expect(quiz!.score, 1);
      expect(quiz!.numberQuestion, 1);
      // Avança um segundo por vez: notificações de respostas não duplicam o timer.
      for (var second = 0; second < 8; second++) {
        await tester.pump(const Duration(seconds: 1));
      }
      expect(quiz!.numberQuestion, 1);
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.text('Resultado final'), findsOneWidget);
      expect(
          result, {'score': 1, 'totalQuestions': 2, 'difficult': difficulty});
      expect(sound.disposals, 1);
      await unmount(tester);
    });
  }
}
