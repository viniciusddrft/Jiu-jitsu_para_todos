import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

/// Thin wrapper around [FirebaseAnalytics] so the rest of the app does not
/// depend on the Firebase SDK directly. Registered as a singleton in
/// `AppCoreModule` and resolved through Modular.
class AnalyticsInteractor {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  /// Navigator observer that automatically logs a `screen_view` event on every
  /// route change. Wired into Modular via `Modular.setObservers([...])`.
  late final FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: _analytics);

  /// Logs which app feature the user opened (history, quiz, wallpaper,
  /// fightmarker, rules, settings...). Emits the recommended `select_content`
  /// event with `item_id = feature`, so the Firebase console can break the
  /// count down per feature.
  Future<void> logFeatureAccess(String feature) async {
    try {
      await _analytics.logSelectContent(
        contentType: 'feature',
        itemId: feature,
      );
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
    }
  }

  /// Generic custom event helper for future use.
  Future<void> logEvent(String name, {Map<String, Object>? params}) async {
    try {
      await _analytics.logEvent(name: name, parameters: params);
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
    }
  }
}
