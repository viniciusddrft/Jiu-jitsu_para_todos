import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:jiu_jitsu_para_todos/src/modules/fightmarker/interactor/clock_interactor.dart';
import 'package:jiu_jitsu_para_todos/src/modules/fightmarker/interactor/scorreboard_interactor.dart';
import 'package:jiu_jitsu_para_todos/src/modules/fightmarker/ui/fightmarker_page.dart';
import 'package:jiu_jitsu_para_todos/src/modules/fightmarker/ui/components/score_board_widget.dart';
import 'package:jiu_jitsu_para_todos/src/modules/fightmarker/ui/components/components/set_timer_widget.dart';
import 'package:jiu_jitsu_para_todos/src/shared/l10n/app_localizations.dart';
import 'package:jiu_jitsu_para_todos/src/shared/plugins/sound/interface/sound_interface.dart';
import '../support/test_app.dart';

void main() {
  testWidgets(
      'placar mantém lutadores independentes; cronômetro configura, pausa, reinicia e toca alarme',
      (tester) async {
    final sound = RecordingSound();
    final orientations = <Object?>[];
    final messenger =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    messenger.setMockMessageHandler(
        'dev.flutter.pigeon.wakelock_plus_platform_interface.WakelockPlusApi.toggle',
        (_) async => const StandardMessageCodec().encodeMessage([null]));
    messenger.setMockMethodCallHandler(SystemChannels.platform, (call) async {
      if (call.method == 'SystemChrome.setPreferredOrientations') {
        orientations.add(call.arguments);
      }
      return null;
    });
    await mount(tester, const FightMakerPage(),
        size: const Size(1200, 800),
        register: (c) => c
          ..addInstance<SoundInterface>(sound)
          ..add(ClockInteractor.new)
          ..add(ScoreboardInteractor.new));
    final timer = tester
        .widget<CircularCountDownTimer>(find.byType(CircularCountDownTimer));
    final firstBoard = find.byType(Scoreboard).first;
    final l = AppLocalizations.of(tester.element(firstBoard))!;
    Finder inFirst(String text) =>
        find.descendant(of: firstBoard, matching: find.text(text));
    String points(int athlete) =>
        tester.widget<Text>(find.byKey(Key('points_$athlete'))).data!;
    // Toque soma: 2 + 3 + 4 pontos, 1 vantagem e 1 punição.
    for (final label in [
      '+2',
      '+3',
      '+4',
      l.fightmarker_advantage,
      l.fightmarker_penalty
    ]) {
      await tester.tap(inFirst(label));
      await tester.pump();
    }
    expect(points(1), '9');
    expect(inFirst('1'), findsNWidgets(2)); // vantagens e punições
    expect(points(2), '0'); // o outro atleta não é afetado
    // Segurar desfaz.
    for (final label in [
      '+2',
      '+3',
      '+4',
      l.fightmarker_advantage,
      l.fightmarker_penalty
    ]) {
      await tester.longPress(inFirst(label));
      await tester.pump();
    }
    expect(points(1), '0');
    expect(inFirst('1'), findsNothing);
    await tester.tap(find.byIcon(Icons.replay_rounded));
    await tester.tap(find.byType(CircularCountDownTimer));
    await tester.pumpAndSettle();
    // Roda dos segundos: desce um item (00 -> 01).
    await tester.drag(
        find.byType(ListWheelScrollView).last, const Offset(0, -48));
    await tester.pumpAndSettle();
    final interactor = tester
        .widget<SetTimerWidget>(find.byType(SetTimerWidget))
        .clockInteractor;
    await tester.tap(find.text(l.text_label_continue));
    await tester.pumpAndSettle();
    expect(interactor.time, 1);
    expect(timer.controller!.getTime(), '00:01');
    await tester.tap(find.byIcon(Icons.play_arrow_rounded));
    await tester.pump();
    expect(interactor.isPause, isFalse);
    await tester.tap(find.byIcon(Icons.pause_rounded));
    await tester.pump();
    expect(interactor.isPause, isTrue);
    await tester.tap(find.byIcon(Icons.replay_rounded));
    await tester.pump();
    expect(interactor.isPause, isTrue);
    await tester.tap(find.byIcon(Icons.play_arrow_rounded));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.replay_rounded));
    await tester.pump();
    expect(interactor.isPause, isTrue);
    await tester.tap(find.byType(CircularCountDownTimer));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l.text_label_cancel_popup));
    await tester.pumpAndSettle();
    expect(interactor.time, 1);
    await tester.tap(find.byIcon(Icons.play_arrow_rounded));
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));
    await tester.pump(const Duration(milliseconds: 300));
    expect(sound.played, contains('assets/music/alarm_sound.mp3'));
    await tester.tap(find.text(l.text_button_stopsound));
    await tester.pumpAndSettle();
    expect(sound.stops, 1);
    await unmount(tester);
    expect(orientations.first, [
      'DeviceOrientation.landscapeLeft',
      'DeviceOrientation.landscapeRight'
    ]);
    expect(orientations.last,
        ['DeviceOrientation.portraitUp', 'DeviceOrientation.portraitDown']);
    expect(sound.disposals, 1);
  });
}
