import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:jiu_jitsu_para_todos/main.dart';
import 'package:jiu_jitsu_para_todos/src/shared/l10n/locale_app.dart';
import 'package:jiu_jitsu_para_todos/src/shared/plugins/analytics/analytics_interactor.dart';
import '../support/test_app.dart';

void main() {
  testWidgets(
      'app restaura idioma salvo e reconstrói localização ao mudar preferência',
      (tester) async {
    final storage = MemoryStorage()..values['locale'] = 'pt_BR';
    final locale = LocaleInteractor(storage);
    await tester.pumpWidget(ModularApp(
      module: createModule(
          register: (c) => c
            ..addInstance<LocaleInteractor>(locale)
            ..addInstance<AnalyticsInteractor>(RecordingAnalytics())
            ..route('/',
                child: (_, __) =>
                    const Scaffold(body: Text('Página inicial')))),
      child: const MyApp(),
    ));
    await tester.pumpAndSettle();
    expect(find.text('Página inicial'), findsOneWidget);
    expect(tester.widget<MaterialApp>(find.byType(MaterialApp)).locale,
        const Locale('pt', 'BR'));
    locale.changeLocale(const Locale('en', 'US'));
    await tester.pumpAndSettle();
    expect(tester.widget<MaterialApp>(find.byType(MaterialApp)).locale,
        const Locale('en', 'US'));
    expect(storage.values['locale'], 'en_US');
    await unmount(tester);
  });
}
