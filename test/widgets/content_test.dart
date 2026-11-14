import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:jiu_jitsu_para_todos/src/modules/historyofjiujitsu/ui/jiujitsuinbrazil/jiu_jitsu_in_brazil_view.dart';
import 'package:jiu_jitsu_para_todos/src/modules/historyofjiujitsu/ui/jiujitsuinindia/jiujitsu_in_india_view.dart';
import 'package:jiu_jitsu_para_todos/src/modules/historyofjiujitsu/ui/jiujitsuinjapan/jiujitsu_in_japan_view.dart';
import 'package:jiu_jitsu_para_todos/src/modules/rules/ui/basicrules/basic_rules_view.dart';
import 'package:jiu_jitsu_para_todos/src/shared/l10n/app_localizations.dart';
import 'package:jiu_jitsu_para_todos/src/shared/plugins/admob/admob_interactor.dart';
import 'package:jiu_jitsu_para_todos/src/shared/shimmer/shimmer_effect.dart';
import 'package:jiu_jitsu_para_todos/src/shared/shimmer/shimmer_widget.dart';
import '../support/test_app.dart';

void main() {
  setUp(mockAdsChannel);
  final pages = <(
    Widget,
    String Function(AppLocalizations),
    String Function(AppLocalizations)
  )>[
    (
      const JiujitsuinBrazilPage(),
      (l) => l.title_appbar_jiujitsu_in_brazil_page,
      (l) => l.text_jiujitsu_in_brazil_paragraph3
    ),
    (
      const JiujitsuInIndiaView(),
      (l) => l.title_appbar_origin_of_jiujitsu_india_page,
      (l) => l.text_origin_of_jiujitsu_india_paragraph5
    ),
    (
      const JiujitsuInJapanView(),
      (l) => l.title_appbar_jiujitsu_in_japan_page,
      (l) => l.text_jiujitsu_in_japan_paragraph7
    ),
    (
      const BasicRulesPage(),
      (l) => l.title_appbar_basic_rules_page,
      (l) => l.text_advantage_and_penalties
    ),
  ];
  for (final locale in [const Locale('pt', 'BR'), const Locale('en', 'US')]) {
    for (final (page, title, paragraph) in pages) {
      testWidgets('${page.runtimeType} exibe título e conteúdo em $locale',
          (tester) async {
        await mount(tester, page,
            locale: locale,
            register: (c) => c.addInstance<AdmobInteractor>(RecordingAds()));
        final l =
            AppLocalizations.of(tester.element(find.byType(page.runtimeType)))!;
        expect(find.text(title(l)), findsOneWidget);
        expect(find.text(paragraph(l)), findsOneWidget);
        await tester.drag(
            find.byType(SingleChildScrollView), const Offset(0, -500));
        await tester.pump();
        expect(tester.takeException(), isNull);
        await unmount(tester);
      });
    }
  }
  testWidgets(
      'shimmer anima nas quatro direções e respeita pausa e limite de ciclos',
      (tester) async {
    Widget shimmer(
            {bool enabled = true,
            int loop = 0,
            ShimmerDirection direction = ShimmerDirection.ltr,
            Duration period = const Duration(milliseconds: 100)}) =>
        localizedApp(Shimmer.fromColors(
            baseColor:
                direction == ShimmerDirection.ltr ? Colors.grey : Colors.blue,
            highlightColor: Colors.white,
            enabled: enabled,
            loop: loop,
            direction: direction,
            period: period,
            child: const Center(
                child: ShimmerWidget.retangular(width: 100, height: 50))));
    await tester.pumpWidget(shimmer());
    expect(find.byType(ShimmerWidget), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 150));
    for (final direction in ShimmerDirection.values) {
      await tester.pumpWidget(shimmer(direction: direction));
      await tester.pump(const Duration(milliseconds: 50));
      expect(tester.takeException(), isNull);
    }
    await tester.pumpWidget(shimmer(enabled: false));
    expect(find.byType(ShimmerWidget), findsOneWidget);
    await tester.pumpWidget(
        shimmer(loop: 2, period: const Duration(milliseconds: 200)));
    await tester.pump(const Duration(milliseconds: 250));
    await tester.pump(const Duration(milliseconds: 250));
    expect(tester.hasRunningAnimations, isFalse);
    await tester.pumpWidget(
        localizedApp(const ShimmerWidget.circular(width: 40, height: 40)));
    final decoration = tester
        .widget<Container>(find.descendant(
            of: find.byType(ShimmerWidget), matching: find.byType(Container)))
        .decoration as ShapeDecoration;
    expect(decoration.shape, isA<CircleBorder>());
    await unmount(tester);
  });
}
