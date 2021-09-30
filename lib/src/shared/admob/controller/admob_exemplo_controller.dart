/*import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jiu_jitsu_para_todos/src/shared/screen_size_for_ad_banner/screen_size_for_ab_Banner.dart';

class Admob {
  static int _numInterstitialLoadAttempts = 0;
  static int _numBannerLoadAttempts = 0;
  static int _maxFailedLoadAttempts = 3;

  static BannerAd? _bannerAd;

  static InterstitialAd? _interstitialAd;

  static BannerAd? get bannerAd => _bannerAd;

  static String get bannerAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111' //this is id for test
      : 'ca-app-pub-3940256099942544/6300978111'; //this is id for test

  static String get interstitialAdUnitID => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712' //this is id for test
      : 'ca-app-pub-3940256099942544/1033173712'; //this is id for test

  static initialize() {
    MobileAds.instance.initialize();
  }

  static BannerAd createBannerAd() {
    BannerAd ad = BannerAd(
      adUnitId: bannerAdUnitId,
      size: screenSizeForAdBanner() ? AdSize.leaderboard : AdSize.fullBanner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) => debugPrint('Ad loaded.'),
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          debugPrint('Ad failed to load: $error');
          _numBannerLoadAttempts++;
          _bannerAd = null;
          if (_numBannerLoadAttempts != _maxFailedLoadAttempts) {
            createBannerAd();
          }
        },
        onAdOpened: (Ad ad) => debugPrint('Ad opened.'),
        onAdClosed: (Ad ad) => debugPrint('Ad closed'),
      ),
    );

    return ad;
  }

  static void showBannerAd() {
    _bannerAd = createBannerAd();
    _bannerAd?..load();
  }

  static void disposeBanner() {
    debugPrint("disposeAds");
    _bannerAd?.dispose();
  }

  static void createAndShowInterstitialAd() {
    InterstitialAd?.load(
      adUnitId: interstitialAdUnitID,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          debugPrint('$ad loaded :| ');
          _interstitialAd = ad;
          _interstitialAd?.show();
          _interstitialAd?.dispose();
          _interstitialAd = null;
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('InterstitialAd failed to load: $error.');
          _numInterstitialLoadAttempts++;
          _interstitialAd = null;
          if (_numInterstitialLoadAttempts != _maxFailedLoadAttempts)
            createAndShowInterstitialAd();
        },
      ),
    );

    _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdImpression: (_) => debugPrint('sucesso!'),
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          debugPrint('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        debugPrint('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createAndShowInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createAndShowInterstitialAd();
      },
    );
  }
}
*/