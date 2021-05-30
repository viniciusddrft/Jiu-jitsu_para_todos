import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Admob {
  static int _numInterstitialLoadAttempts = 0;
  static int maxFailedLoadAttempts = 3;
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
      size: AdSize.leaderboard,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) => print('Ad loaded.'),
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Ad failed to load: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('Ad opened.'),
        onAdClosed: (Ad ad) => print('Ad closed.'),
      ),
    );

    return ad;
  }

  static void showBannerAd() {
    if (_bannerAd != null) {
      return;
    }
    _bannerAd = createBannerAd();
    _bannerAd?..load();
  }

  void disposeAds() {
    print("disposeAds");
    if (_bannerAd != null) {
      _bannerAd?.dispose();
    }
  }

  static void createInterstitialAd() {
    InterstitialAd?.load(
      adUnitId: interstitialAdUnitID,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          print('$ad loaded :| ');
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error.');
          _numInterstitialLoadAttempts++;
          _interstitialAd = null;
          if (_numInterstitialLoadAttempts != maxFailedLoadAttempts) {
            createInterstitialAd();
          }
        },
      ),
    );

    _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdImpression: (_) => print('sucesso!'),
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createInterstitialAd();
      },
    );
  }

  static void showInterstitialAd() {
    _interstitialAd?.show();
    _interstitialAd?.dispose();
    _interstitialAd = null;
  }
}
