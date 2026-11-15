import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jiu_jitsu_para_todos/src/shared/plugins/haptics/app_haptics.dart';

import '../support/test_app.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final calls = <Object?>[];

  setUp(() {
    calls.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, (call) async {
      if (call.method == 'HapticFeedback.vibrate') calls.add(call.arguments);
      return null;
    });
    AppHaptics.enabled.value = true;
  });

  test('vem ligada por padrão e respeita a preferência salva', () async {
    final storage = MemoryStorage();
    AppHaptics.enabled.value = false;
    await AppHaptics.load(storage);
    expect(AppHaptics.enabled.value, isTrue);

    storage.values[AppHaptics.storageKey] = 0;
    await AppHaptics.load(storage);
    expect(AppHaptics.enabled.value, isFalse);
  });

  test('cada uso tem o padrão de vibração do Android', () {
    AppHaptics.key();
    AppHaptics.undo();
    AppHaptics.selection();
    AppHaptics.success();
    AppHaptics.error();
    expect(calls, [
      'HapticFeedbackType.lightImpact',
      'HapticFeedbackType.mediumImpact',
      'HapticFeedbackType.selectionClick',
      'HapticFeedbackType.successNotification',
      'HapticFeedbackType.errorNotification',
    ]);
  });

  test('desligada não vibra; ao religar, salva e dá um toque de exemplo',
      () async {
    final storage = MemoryStorage();
    await AppHaptics.load(storage);

    AppHaptics.setEnabled(false);
    expect(storage.values[AppHaptics.storageKey], 0);
    AppHaptics.key();
    AppHaptics.success();
    await AppHaptics.alarm();
    expect(calls, isEmpty);

    AppHaptics.setEnabled(true);
    expect(storage.values[AppHaptics.storageKey], 1);
    expect(calls, ['HapticFeedbackType.selectionClick']);
  });

  test('alarme vibra três vezes', () async {
    await AppHaptics.alarm();
    expect(calls, [null, null, null]);
  });
}
