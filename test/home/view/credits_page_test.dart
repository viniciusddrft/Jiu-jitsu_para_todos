import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jiu_jitsu_para_todos/core/locale/locale_app.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jiu_jitsu_para_todos/src/modules/credits/view/credits_view.dart';

void main() {
  group('Tela Creditos', () {
    testWidgets('Deve mostrar 1 Appbar, 3 textos e 2 Icons',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        LocaleApp(
          notifier: LocaleAppNotifier(),
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Locale('en', 'Us'),
            home: CreditsView(),
          ),
        ),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byKey(const Key('icon flaticon')), findsOneWidget);
      expect(find.byKey(const Key('icon flutter')), findsOneWidget);
      expect(find.byKey(const Key('text flaticon')), findsOneWidget);
      expect(find.byKey(const Key('text flutter')), findsOneWidget);
      expect(find.byKey(const Key('text click')), findsOneWidget);
    });
  });
}
