import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jiu_jitsu_para_todos/src/modules/home/ui/home_page.dart';
import 'package:jiu_jitsu_para_todos/src/shared/components/button_menu.dart';
import 'package:jiu_jitsu_para_todos/src/shared/l10n/app_localizations.dart';
import 'package:jiu_jitsu_para_todos/src/shared/plugins/analytics/analytics_interactor.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';
import 'package:material_ui/material_ui.dart';

class FakeAnalytics implements AnalyticsInteractor {
  @override
  Future<void> logFeatureAccess(String feature) async {}
  @override
  Future<void> logEvent(String name, {Map<String, Object>? params}) async {}
}

final testModule = createModule(
  register: (c) => c.addSingleton<AnalyticsInteractor>(FakeAnalytics.new),
);

void main() {
  testWidgets('Teste homePage', (WidgetTester tester) async {
    await tester.pumpWidget(
      ModularApp(
        module: testModule,
        child: MaterialApp(
          title: 'Jiu-jitsu para todos',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            ...GlobalMaterialLocalizations.delegates,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en', 'Us'),
          theme: ThemeData(
            primaryColor: AppColors.primary,
            brightness: Brightness.dark,
            useMaterial3: true,
          ),
          home: const HomePage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(ButtonMenu), findsNWidgets(5));
  });
}
