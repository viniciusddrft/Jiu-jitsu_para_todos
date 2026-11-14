import 'package:flutter/services.dart';
import 'package:google_mobile_ads/src/ad_instance_manager.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jiu_jitsu_para_todos/src/shared/l10n/app_localizations.dart';
import 'package:jiu_jitsu_para_todos/src/shared/plugins/admob/admob_interactor.dart';
import 'package:jiu_jitsu_para_todos/src/shared/plugins/analytics/analytics_interactor.dart';
import 'package:jiu_jitsu_para_todos/src/shared/plugins/in_app_review/in_app_review_interactor.dart';
import 'package:jiu_jitsu_para_todos/src/shared/plugins/local_storage/interface/local_storage_interface.dart';
import 'package:jiu_jitsu_para_todos/src/shared/plugins/sound/interface/sound_interface.dart';
import 'package:material_ui/material_ui.dart';

class MemoryStorage implements ILocalStorage {
  final values = <String, Object>{};
  @override
  Future<T?> getValue<T>(String key) async => values[key] as T?;
  @override
  void saveValue<T>(String key, T value) => values[key] = value as Object;
  @override
  void remove(String key) => values.remove(key);
}

class RecordingSound implements SoundInterface {
  final played = <String>[];
  int pauses = 0, stops = 0, disposals = 0;
  @override
  Future<void> play(String soundPath) async => played.add(soundPath);
  @override
  void pause() => pauses++;
  @override
  void stop() => stops++;
  @override
  void dispose() => disposals++;
}

class RecordingAds extends AdmobInteractor {
  int loads = 0, shows = 0;
  @override
  void createInterstitialAd() => loads++;
  @override
  void showInterstitialAd() => shows++;
}

class RecordingAnalytics implements AnalyticsInteractor {
  final features = <String>[];
  @override
  Future<void> logFeatureAccess(String feature) async => features.add(feature);
  @override
  Future<void> logEvent(String name, {Map<String, Object>? params}) async {}
}

class RecordingReview extends InAppReviewInteractor {
  RecordingReview() : super(MemoryStorage());
  bool handled = false;
  int storeRequests = 0;
  final scores = <double>[];
  @override
  Future<bool> registerQuizCompletionAndMaybeReview(
      {required double scorePercentage}) async {
    scores.add(scorePercentage);
    return handled;
  }

  @override
  Future<void> openStoreListing() async => storeRequests++;
}

void mockAdsChannel() {
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(
          MethodChannel('plugins.flutter.io/google_mobile_ads',
              StandardMethodCodec(AdMessageCodec())),
          (_) async => null);
}

Widget localizedApp(Widget home, {Locale locale = const Locale('en', 'US')}) =>
    MaterialApp(
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      // ignore: deprecated_member_use
      builder: (_, child) => MaterialUiCompatibilityBridge(child: child!),
      home: home,
    );

Future<void> mount(
  WidgetTester tester,
  Widget page, {
  void Function(ModularContext)? register,
  Locale locale = const Locale('en', 'US'),
  Size size = const Size(1000, 1000),
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(ModularApp(
    module: createModule(register: register ?? (_) {}),
    child: localizedApp(page, locale: locale),
  ));
  await tester.pump();
}

Future<void> unmount(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump();
}

Future<void> mountRouter(WidgetTester tester, Module module) async {
  tester.view.physicalSize = const Size(1000, 1000);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(ModularApp(
      module: module,
      child: Builder(
          builder: (context) => MaterialApp.router(
                routerConfig: ModularApp.routerConfigOf(context),
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  ...GlobalMaterialLocalizations.delegates
                ],
                supportedLocales: AppLocalizations.supportedLocales,
                locale: const Locale('en', 'US'),
              ))));
  await tester.pump();
}
