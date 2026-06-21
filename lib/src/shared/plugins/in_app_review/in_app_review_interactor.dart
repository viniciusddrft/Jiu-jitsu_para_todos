import 'package:flutter/foundation.dart';
import 'package:in_app_review/in_app_review.dart';

import '../../mixins/launch_link.dart';
import '../local_storage/interface/local_storage_interface.dart';

class InAppReviewInteractor with OpenLink {
  InAppReviewInteractor(this._localStorage);

  final ILocalStorage _localStorage;
  final InAppReview _inAppReview = InAppReview.instance;

  static const _completionsKey = 'review_quiz_completions';
  static const _lastRequestKey = 'review_last_request_iso';
  static const _playStoreUrl =
      'https://play.google.com/store/apps/details?id=com.jiu_jitsu_para_todos';

  static const _minCompletions = 3;

  static const _minScore = 0.75;

  static const _cooldown = Duration(days: 90);

  Future<bool> registerQuizCompletionAndMaybeReview({
    required double scorePercentage,
  }) async {
    final int completions =
        (await _localStorage.getValue<int>(_completionsKey) ?? 0) + 1;
    _localStorage.saveValue<int>(_completionsKey, completions);

    if (scorePercentage < _minScore) return false;
    if (completions < _minCompletions) return false;
    if (!_cooldownElapsed(
        await _localStorage.getValue<String>(_lastRequestKey))) {
      return false;
    }

    try {
      if (!await _inAppReview.isAvailable()) return false;
      await _inAppReview.requestReview();
      _localStorage.saveValue<String>(
          _lastRequestKey, DateTime.now().toIso8601String());
      return true;
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
      return false;
    }
  }

  Future<void> openStoreListing() async {
    try {
      if (await _inAppReview.isAvailable()) {
        await _inAppReview.openStoreListing();
        return;
      }
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
    }
    await openLink(_playStoreUrl);
  }

  bool _cooldownElapsed(String? lastRequestIso) {
    if (lastRequestIso == null) return true;
    final DateTime? last = DateTime.tryParse(lastRequestIso);
    if (last == null) return true;
    return DateTime.now().difference(last) > _cooldown;
  }
}
