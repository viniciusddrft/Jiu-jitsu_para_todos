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
    for (var index = 0; index < 5; index++) {
      final add = find
          .descendant(of: firstBoard, matching: find.byIcon(Icons.add))
          .at(index);
      await tester.tap(add);
      await tester.pump();
    }
    final totals = find.descendant(of: firstBoard, matching: find.byType(Text));
    expect(tester.widget<Text>(totals.at(0)).data, '9');
    expect(tester.widget<Text>(totals.at(1)).data, '1');
    expect(tester.widget<Text>(totals.at(2)).data, '1');
    final otherTotals = find.descendant(
        of: find.byType(Scoreboard).last, matching: find.byType(Text));
    expect(tester.widget<Text>(otherTotals.first).data, '0');
    for (var index = 0; index < 5; index++) {
      await tester.tap(find
          .descendant(of: firstBoard, matching: find.byIcon(Icons.remove))
          .at(index));
      await tester.pump();
    }
    expect(tester.widget<Text>(totals.at(0)).data, '0');
    await tester.tap(find.byIcon(Icons.refresh_rounded));
    await tester.tap(find.byType(CircularCountDownTimer));
    await tester.pumpAndSettle();
    final l = AppLocalizations.of(tester.element(find.byType(SetTimerWidget)))!;
    await tester.tap(find.byIcon(Icons.keyboard_arrow_up).first);
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.keyboard_arrow_down).first);
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.keyboard_arrow_up).last);
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.keyboard_arrow_down).last);
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.keyboard_arrow_up).last);
    await tester.pumpAndSettle();
    final interactor = tester
        .widget<SetTimerWidget>(find.byType(SetTimerWidget))
        .clockInteractor;
    await tester.tap(find.text(l.text_label_continue));
    await tester.pumpAndSettle();
    expect(interactor.time, 1);
    expect(timer.controller!.getTime(), '00:01');
    await tester.tap(find.byIcon(Icons.play_arrow));
    await tester.pump();
    expect(interactor.isPause, isFalse);
    await tester.tap(find.byIcon(Icons.pause));
    await tester.pump();
    expect(interactor.isPause, isTrue);
    await tester.tap(find.byIcon(Icons.refresh_rounded));
    await tester.pump();
    expect(interactor.isPause, isTrue);
    await tester.tap(find.byIcon(Icons.play_arrow));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.refresh_rounded));
    await tester.pump();
    expect(interactor.isPause, isTrue);
    await tester.tap(find.byType(CircularCountDownTimer));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l.text_label_cancel_popup));
    await tester.pumpAndSettle();
    expect(interactor.time, 1);
    await tester.tap(find.byIcon(Icons.play_arrow));
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
