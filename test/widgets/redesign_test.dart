import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/interactor/answer_entity.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/interactor/question_entity.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/ui/quiz_questions/components/button_quiz_widget.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/ui/quiz_questions/components/quiz_media.dart';
import 'package:jiu_jitsu_para_todos/src/shared/components/belt.dart';
import 'package:jiu_jitsu_para_todos/src/shared/l10n/app_localizations.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';
import 'package:material_ui/material_ui.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:video_player_platform_interface/video_player_platform_interface.dart';

import '../support/network_images.dart';
import '../support/test_app.dart';

/// Player de vídeo falso: inicializa na hora e registra as chamadas.
class FakeVideoPlatform extends VideoPlayerPlatform
    with MockPlatformInterfaceMixin {
  final calls = <String>[];
  final _events = StreamController<VideoEvent>.broadcast();
  double speed = 1;

  @override
  Future<void> init() async {}
  @override
  Future<int?> createWithOptions(VideoCreationOptions options) async {
    calls.add('create:${options.dataSource.uri ?? options.dataSource.asset}');
    return 1;
  }

  // Emite "inicializado" assim que o player começa a escutar.
  @override
  Stream<VideoEvent> videoEventsFor(int playerId) async* {
    yield VideoEvent(
      eventType: VideoEventType.initialized,
      duration: const Duration(seconds: 10),
      size: const Size(1920, 1080),
    );
    yield* _events.stream;
  }

  @override
  Future<void> setLooping(int playerId, bool looping) async {}
  @override
  Future<void> setVolume(int playerId, double volume) async {}
  @override
  Future<void> play(int playerId) async => calls.add('play');
  @override
  Future<void> pause(int playerId) async => calls.add('pause');
  @override
  Future<void> seekTo(int playerId, Duration position) async =>
      calls.add('seek:${position.inSeconds}');
  @override
  Future<void> setPlaybackSpeed(int playerId, double speed) async =>
      this.speed = speed;
  @override
  Future<Duration> getPosition(int playerId) async => Duration.zero;
  @override
  Widget buildViewWithOptions(VideoViewOptions options) =>
      const ColoredBox(color: Colors.black);
  @override
  Future<void> dispose(int playerId) async => calls.add('dispose');
}

QuestionEntity questionWith({String? image, String? video}) => QuestionEntity(
      question: 'Quantos pontos?',
      pathImage: image,
      pathVideo: video,
      options: const [AnswerEntity(text: '2', isCorrect: true)],
    );

void main() {
  setUp(mockNetworkImages);

  testWidgets('pergunta sem mídia não reserva espaço', (tester) async {
    await mount(tester, Scaffold(body: QuizMedia(question: questionWith())));
    expect(QuizMedia.hasMedia(questionWith()), isFalse);
    expect(find.byType(Image), findsNothing);
    await unmount(tester);
  });

  testWidgets('pergunta com imagem mostra a imagem e abre em tela cheia',
      (tester) async {
    final q = questionWith(image: 'https://example.com/posicao.png');
    expect(QuizMedia.hasMedia(q), isTrue);
    await mount(tester, Scaffold(body: QuizMedia(question: q)));
    final l = AppLocalizations.of(tester.element(find.byType(QuizMedia)))!;
    expect(find.text(l.quiz_media_image.toUpperCase()), findsOneWidget);
    await tester.tap(find.byType(Image).first);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.byType(InteractiveViewer), findsOneWidget);
    await tester.tap(find.byIcon(Icons.close_rounded));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.byType(InteractiveViewer), findsNothing);
    await unmount(tester);
  });

  testWidgets('pergunta com vídeo toca, repete e alterna câmera lenta',
      (tester) async {
    final platform = FakeVideoPlatform();
    VideoPlayerPlatform.instance = platform;
    // Se vierem imagem e vídeo por erro de cadastro, o vídeo tem prioridade.
    final q = questionWith(
        image: 'https://example.com/capa.png',
        video: 'https://example.com/lance.mp4');
    await mount(tester, Scaffold(body: QuizMedia(question: q)));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    final l = AppLocalizations.of(tester.element(find.byType(QuizMedia)))!;
    expect(platform.calls.first, 'create:https://example.com/lance.mp4');
    expect(find.text(l.quiz_media_video.toUpperCase()), findsOneWidget);

    await tester.tap(find.byIcon(Icons.play_arrow_rounded));
    await tester.pump();
    expect(platform.calls, contains('play'));

    await tester.tap(find.text(l.quiz_video_replay));
    await tester.pump();
    expect(platform.calls, contains('seek:0'));

    await tester.tap(find.text(l.quiz_video_slow));
    await tester.pump();
    expect(platform.speed, 0.5);
    await tester.tap(find.text(l.quiz_video_slow));
    await tester.pump();
    expect(platform.speed, 1);

    await unmount(tester);
  });

  testWidgets('resposta curta em grade mostra o resultado no próprio botão',
      (tester) async {
    AnswerEntity? chosen;
    const answer = AnswerEntity(text: '3', isCorrect: false);
    await mount(
        tester,
        Scaffold(
          body: SizedBox(
            width: 180,
            height: 80,
            child: ButtonQuizQuestionsWidget(
              answerEntity: answer,
              compact: true,
              onPressedButton: (a) => chosen = a,
            ),
          ),
        ));
    await tester.tap(find.text('3'));
    await tester.pump();
    expect(find.byIcon(Icons.close_rounded), findsOneWidget);
    // Tocar de novo durante o feedback não responde duas vezes.
    await tester.tap(find.text('3'));
    await tester.pump(const Duration(milliseconds: 500));
    expect(chosen, same(answer));
    await unmount(tester);
  });

  testWidgets('faixas sempre têm ponteira; símbolo grande mostra os graus',
      (tester) async {
    await mount(
        tester,
        const Scaffold(
          body: Column(children: [
            Belt(belt: BeltColor.purple),
            BrandBelt(width: 160),
          ]),
        ));
    expect(BeltColor.white.tip, AppColors.beltBlack);
    expect(BeltColor.black.tip, AppColors.accent);
    final stripes = find.descendant(
        of: find.byType(BrandBelt),
        matching: find.byWidgetPredicate(
            (w) => w is Container && w.color == AppColors.text));
    expect(stripes, findsNWidgets(2));
    await unmount(tester);
  });
}
