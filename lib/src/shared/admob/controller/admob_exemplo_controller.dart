import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Admob {
  static int _numInterstitialLoadAttempts = 0;
  static int _numBannerLoadAttempts = 0;
  static const int _maxFailedLoadAttempts = 3;

  static InterstitialAd? _interstitialAd;

  static late int heightAnchoredBanner;

  static late int widthAnchoredBanner;

  static String get _bannerAdUnitId => 'id test';

  static String get _interstitialAdUnitID => 'id test';
//------------------------------------------------------------------------------
  static Future<BannerAd?> createAnchoredBanner(BuildContext context) async {
    final AnchoredAdaptiveBannerAdSize? _size =
        await AdSize.getAnchoredAdaptiveBannerAdSize(
      Orientation.portrait,
      MediaQuery.of(context).size.width.truncate(),
    );

    if (_size == null) {
      debugPrint('Unable to get height of anchored banner.');
      return null;
    }

    final BannerAd banner = BannerAd(
      size: _size,
      request: const AdRequest(),
      adUnitId: _bannerAdUnitId,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          debugPrint('$BannerAd loaded.');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          debugPrint('Ad failed to load: $error');
          _numBannerLoadAttempts++;
          if (_numBannerLoadAttempts != _maxFailedLoadAttempts) {
            createAnchoredBanner(context);
          } else {
            ad.dispose();
          }
        },
        onAdOpened: (Ad ad) => debugPrint('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => debugPrint('$BannerAd onAdClosed.'),
        onAdImpression: (Ad ad) => debugPrint('ad shown successfully |o/'),
      ),
    );
    return banner;
  }

//------------------------------------------------------------------------------
//Used to load ads into didChangeDependencies to optimize
  static void createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: _interstitialAdUnitID,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          debugPrint('$ad loaded in didChangeDependencies :)');
          _interstitialAd = ad;
          _numInterstitialLoadAttempts = 0;
          _interstitialAd!.setImmersiveMode(true);
          if (_interstitialAd == null) {
            debugPrint('Warning: attempt to show interstitial before loaded.');
            return;
          }
          _interstitialAd?.fullScreenContentCallback =
              FullScreenContentCallback(
            onAdShowedFullScreenContent: (InterstitialAd ad) =>
                debugPrint('ad onAdShowedFullScreenContent.'),
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              debugPrint('$ad onAdDismissedFullScreenContent.');
              ad.dispose();
              createInterstitialAd();
            },
            onAdFailedToShowFullScreenContent:
                (InterstitialAd ad, AdError error) {
              debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
              ad.dispose();
              createInterstitialAd();
            },
            onAdImpression: (InterstitialAd ad) =>
                debugPrint('ad shown successfully |o/ | didChangeDependencies'),
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('InterstitialAd failed to load: $error.');
          _numInterstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_numInterstitialLoadAttempts <= _maxFailedLoadAttempts) {
            createInterstitialAd();
          }
        },
      ),
    );
  }

  //Checks if the ad has already been loaded in didChangeDependencies and shows it otherwise it calls a function to load the ad and show
  static void showInterstitialAd() {
    if (_interstitialAd != null) {
      debugPrint('ad is now ready to be shown');
      _interstitialAd!.show();
      _interstitialAd!.dispose();
      _interstitialAd = null;
    } else {
      debugPrint('making an ad to show it');
      _createAndShowInterstitialAd();
    }
  }

  //Used when the ad has not yet been uploaded to didChangeDependencies
  static void _createAndShowInterstitialAd() {
    InterstitialAd.load(
      adUnitId: _interstitialAdUnitID,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          debugPrint('$ad loaded');
          _interstitialAd = ad;
          _numInterstitialLoadAttempts = 0;
          _interstitialAd!.setImmersiveMode(true);
          if (_interstitialAd == null) {
            debugPrint('Warning: attempt to show interstitial before loaded.');
            return;
          }
          _interstitialAd?.fullScreenContentCallback =
              FullScreenContentCallback(
            onAdShowedFullScreenContent: (InterstitialAd ad) =>
                debugPrint('ad onAdShowedFullScreenContent.'),
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              debugPrint('$ad onAdDismissedFullScreenContent.');
              ad.dispose();
              _createAndShowInterstitialAd();
            },
            onAdFailedToShowFullScreenContent:
                (InterstitialAd ad, AdError error) {
              debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
              ad.dispose();
              _createAndShowInterstitialAd();
            },
            onAdImpression: (InterstitialAd ad) =>
                debugPrint('ad shown successfully |o/'),
          );
          _interstitialAd?.show();
          _interstitialAd?.dispose();
          _interstitialAd = null;
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('InterstitialAd failed to load: $error.');
          _numInterstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_numInterstitialLoadAttempts <= _maxFailedLoadAttempts) {
            _createAndShowInterstitialAd();
          }
        },
      ),
    );
  }
}
