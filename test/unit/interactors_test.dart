import 'dart:async';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:jiu_jitsu_para_todos/src/modules/fightmarker/interactor/scorreboard_interactor.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/interactor/quiz_interactor.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/interactor/quiz_state.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/interactor/interfaces/ifirebase_quiz.dart';
import 'package:jiu_jitsu_para_todos/src/modules/rules/interactor/rules_interactor.dart';
import 'package:jiu_jitsu_para_todos/src/modules/rules/interactor/rules_state.dart';
import 'package:jiu_jitsu_para_todos/src/modules/rules/interactor/interfaces/rules_service_interface.dart';
import 'package:jiu_jitsu_para_todos/src/modules/wallpapers/interactor/wallpaper_interactor.dart';
import 'package:jiu_jitsu_para_todos/src/modules/wallpapers/interactor/wallpaper_state.dart';
import 'package:jiu_jitsu_para_todos/src/modules/wallpapers/interactor/wallpaper_entity.dart';
import 'package:jiu_jitsu_para_todos/src/modules/wallpapers/interactor/interfaces/ifirebase_wallpapers.dart';
import 'package:jiu_jitsu_para_todos/src/modules/settings/interactor/settings_interactor.dart';
import 'package:jiu_jitsu_para_todos/src/shared/l10n/locale_app.dart';
import 'package:jiu_jitsu_para_todos/src/shared/plugins/sound/interface/sound_interface.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_icons_languages_path.dart';
import '../support/test_app.dart';
import '../support/quiz_fixture.dart';

class PendingRules implements RulesServiceInterface {
  final response = Completer<RulesState>();
  String? url, name;
  @override
  Future<RulesState> downloadPDf(String url, String name) {
    this.url = url;
    this.name = name;
    return response.future;
  }
}

class PendingWallpapers implements IFirebaseWallpapers {
  final response = Completer<WallpaperState>();
  bool? refresh;
  @override
  Future<WallpaperState> loadWallpapers({bool forceRefresh = false}) {
    refresh = forceRefresh;
    return response.future;
  }
}

void main() {
  late MemoryStorage storage;
  late LocaleInteractor locale;
  late RecordingSound sound;
  setUp(() {
    storage = MemoryStorage();
    locale = LocaleInteractor(storage);
    sound = RecordingSound();
    final boot = bootstrapModule(createModule(
        register: (c) => c
          ..addInstance<LocaleInteractor>(locale)
          ..addInstance<SoundInterface>(sound)));
    addTearDown(boot.injector.dispose);
  });

  test('placar soma e remove pontos sem permitir valores negativos', () {
    final score = ScoreboardInteractor();
    addTearDown(score.dispose);
    var notifications = 0;
    score.addListener(() => notifications++);
    for (final points in [2, 3, 4]) {
      score.addPoints(points);
      expect(score.fighterPoints, points);
      score.removePoints(points);
      expect(score.fighterPoints, 0);
    }
    score.removePoints(4);
    score.removeAdvantages();
    score.removePunishments();
    expect([
      score.fighterPoints,
      score.advantagesOfTheFighter,
      score.punishmentsOfTheFighter
    ], [
      0,
      0,
      0
    ]);
    score.addAdvantages();
    score.addPunishments();
    expect(
        [score.advantagesOfTheFighter, score.punishmentsOfTheFighter], [1, 1]);
    score.removeAdvantages();
    score.removePunishments();
    expect(
        [score.advantagesOfTheFighter, score.punishmentsOfTheFighter], [0, 0]);
    expect(notifications, 13);
  });

  test('placar desfaz a última ação, uma de cada vez', () {
    final score = ScoreboardInteractor();
    addTearDown(score.dispose);
    expect(score.canUndo, isFalse);
    score.undo(); // sem histórico não faz nada
    score
      ..addPoints(2)
      ..addAdvantages()
      ..addPoints(4)
      ..addPunishments();
    expect(score.canUndo, isTrue);
    score.undo();
    expect(score.punishmentsOfTheFighter, 0);
    score.undo();
    expect(score.fighterPoints, 2);
    score.undo();
    expect(score.advantagesOfTheFighter, 0);
    score.undo();
    expect(score.fighterPoints, 0);
    expect(score.canUndo, isFalse);
  });

  for (final difficulty in Difficult.values) {
    test(
        'quiz carrega $difficulty no idioma selecionado e contabiliza respostas e timeout',
        () async {
      locale.changeLocale(const Locale('pt', 'BR'));
      final repository = PendingQuiz();
      final quiz = QuizInteractor(firebaseQuiz: repository);
      quiz.loadQuestions(difficulty);
      expect(quiz.value, isA<QuizLoading>());
      expect(repository.difficulty, difficulty);
      expect(repository.language, '_pt');
      repository.response
          .complete(const QuizSuccess([question, question, question]));
      await Future<void>.delayed(Duration.zero);
      expect(quiz.value, isA<QuizSuccess>());
      expect(quiz.totalQuestions, 3);
      var notifications = 0;
      quiz.addListener(() => notifications++);
      quiz.onPressed(question.options.first);
      await Future<void>.delayed(Duration.zero);
      expect(quiz.score, 1);
      expect(quiz.numberQuestion, 1);
      expect(sound.played,
          ['assets/music/right_answer.mp3', 'assets/music/timer.mp3']);
      quiz.onPressed(question.options.last);
      quiz.onTimerFailed();
      await Future<void>.delayed(Duration.zero);
      expect(quiz.score, 1);
      expect(quiz.numberQuestion, 3);
      expect(notifications, 3);
      expect(sound.pauses, 3);
      expect(sound.played.where((p) => p.endsWith('wrong_answer.mp3')),
          hasLength(2));
      quiz.dispose();
      expect(sound.disposals, 1);
    });
  }
  test('quiz publica falha do repositório', () async {
    final repository = PendingQuiz();
    final quiz = QuizInteractor(firebaseQuiz: repository);
    addTearDown(quiz.dispose);
    quiz.loadQuestions(Difficult.easy);
    repository.response.complete(const QuizFailed());
    await Future<void>.delayed(Duration.zero);
    expect(quiz.value, isA<QuizFailed>());
    expect(quiz.totalQuestions, 0);
  });
  for (final result in <RulesState>[
    const SuccessDownload(),
    const FailedDownload('offline')
  ]) {
    test('download publica loading e ${result.runtimeType}', () async {
      final service = PendingRules();
      final rules = RulesInteractor(service);
      addTearDown(rules.dispose);
      expect(rules.value, isA<InitialRules>());
      rules.downloadPDf('https://example.com/rules.pdf');
      expect(rules.value, isA<LoadingDownload>());
      expect(service.url, 'https://example.com/rules.pdf');
      expect(service.name, matches(RegExp(r'^[a-z]{10}$')));
      service.response.complete(result);
      await Future<void>.delayed(Duration.zero);
      expect(rules.value, same(result));
      if (result is FailedDownload) expect(result.message, 'offline');
    });
  }
  for (final refresh in [false, true]) {
    for (final result in <WallpaperState>[
      const WallpaperSuccess([WallpaperEntity(url: 'image')]),
      const WallpaperFailed()
    ]) {
      test('wallpapers refresh=$refresh publica ${result.runtimeType}',
          () async {
        final repository = PendingWallpapers();
        final interactor = WallpaperInteractor(firebaseWallpapers: repository);
        addTearDown(interactor.dispose);
        interactor.loadWallpapers(forceRefresh: refresh);
        expect(interactor.value, isA<WallpaperLoading>());
        expect(repository.refresh, refresh);
        repository.response.complete(result);
        await Future<void>.delayed(Duration.zero);
        expect(interactor.value, same(result));
      });
    }
  }
  test('idioma restaura preferência e persiste seleção', () async {
    storage.values['locale'] = 'pt_BR';
    await locale.getLocalePreference();
    expect(locale.value, const Locale('pt', 'BR'));
    locale.changeLocale(const Locale('en', 'US'));
    expect(storage.values['locale'], 'en_US');
  });
  test('idioma usa o sistema suportado ou inglês como fallback', () async {
    final original = Intl.systemLocale;
    addTearDown(() => Intl.systemLocale = original);
    Intl.systemLocale = 'pt_BR';
    await locale.getLocalePreference();
    expect(locale.value.languageCode, 'pt');
    Intl.systemLocale = 'fr_FR';
    await locale.getLocalePreference();
    expect(locale.value.languageCode, 'en');
  });
  test('configurações associam idioma à bandeira e salvam escolha', () {
    final settings = SettingsInteractor();
    addTearDown(settings.dispose);
    settings.loadLanguage();
    expect(settings.iconPath.value, AppIconsLanguages.unitedStates);
    locale.changeLocale(const Locale('pt', 'BR'));
    settings.loadLanguage();
    expect(settings.iconPath.value, AppIconsLanguages.brasil);
    settings.saveLanguage({
      'locale': const Locale('en', 'US'),
      'icon': AppIconsLanguages.unitedStates
    });
    expect(locale.value, const Locale('en', 'US'));
    expect(settings.iconPath.value, AppIconsLanguages.unitedStates);
    expect(storage.values['locale'], 'en_US');
  });
}
