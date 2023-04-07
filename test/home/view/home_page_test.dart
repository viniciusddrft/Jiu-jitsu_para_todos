import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jiu_jitsu_para_todos/core/locale/locale_app.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jiu_jitsu_para_todos/src/modules/home/view/components/button_options_home_widget.dart';

import 'package:jiu_jitsu_para_todos/src/modules/home/view/home_page_view.dart';

void main() {
  group('Tela home', () {
    testWidgets('Deve mostrar a appBar e os botões',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        LocaleApp(
          notifier: LocaleAppNotifier(),
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Locale('en', 'Us'),
            home: HomePageView(),
          ),
        ),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(IconButton), findsOneWidget);
      expect(find.byType(ButtonOptionsHome), findsNWidgets(5));
    });
  });
}
