import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Admob {
  static BannerAd _bannerAd;
  static InterstitialAd _interstitialAd;

  static BannerAd get bannerAd => _bannerAd;
  static String get bannerAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'//this is id for test
      : 'ca-app-pub-3940256099942544/6300978111';//this is id for test

  static String get interstitialAdUnitID => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712'//this is id for test
      : 'ca-app-pub-3940256099942544/1033173712';//this is id for test

  static initialize() {
    if (MobileAds.instance == null) {
      MobileAds.instance.initialize();
    }
  }

  static BannerAd createBannerAd() {
    BannerAd ad = new BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.fullBanner,
      request: AdRequest(),
      listener: AdListener(
        onAdLoaded: (Ad ad) => print('Ad loaded.'),
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Ad failed to load: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('Ad opened.'),
        onAdClosed: (Ad ad) => print('Ad closed.'),
        onApplicationExit: (Ad ad) => print('Left application.'),
      ),
    );

    return ad;
  }

  static void showBannerAd() {
    if (_bannerAd != null) {
      return;
    }
    _bannerAd = createBannerAd();
    _bannerAd..load();
  }

  void disposeAds() {
    print("disposeAds");
    if (_bannerAd != null) {
      _bannerAd?.dispose();
    }
  }

  static InterstitialAd _createInterstitialAd() {
    return InterstitialAd(
      adUnitId: interstitialAdUnitID,
      request: AdRequest(),
      listener: AdListener(
        onAdLoaded: (Ad ad) => {_interstitialAd.show()},
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Ad failed to load: $error');
        },
        onAdOpened: (Ad ad) => print('Ad opened.'),
        onAdClosed: (Ad ad) => {_interstitialAd.dispose()},
        onApplicationExit: (Ad ad) => {_interstitialAd.dispose()},
      ),
    );
  }

  static void showInterstitialAd() {
    _interstitialAd?.dispose();
    _interstitialAd = null;

    if (_interstitialAd == null) _interstitialAd = _createInterstitialAd();

    _interstitialAd.load();
  }
}
