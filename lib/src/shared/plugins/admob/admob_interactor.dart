import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobInteractor extends ChangeNotifier {
  int _numInterstitialLoadAttempts = 0;
  final int _maxFailedLoadAttempts = 3;

  InterstitialAd? _interstitialAd;

  final nativeAdUnitIDListTile = 'ca-app-pub-3443422868739312/4729209196';
  final _interstitialAdUnitID = 'ca-app-pub-3443422868739312/8213285296';

  static void initialize() => MobileAds.instance.initialize();

//------------------------------------------------------------------------------
//Used to load ads into didChangeDependencies to optimize
  void createInterstitialAd() => InterstitialAd.load(
        adUnitId: _interstitialAdUnitID,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            debugPrint('$ad loaded in didChangeDependencies :)');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
            if (_interstitialAd == null) {
              debugPrint(
                  'Warning: attempt to show interstitial before loaded.');
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
              onAdImpression: (InterstitialAd ad) => debugPrint(
                  'ad shown successfully |o/ | didChangeDependencies'),
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

  //Checks if the ad has already been loaded in didChangeDependencies and shows it otherwise it calls a function to load the ad and show
  void showInterstitialAd() {
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
  void _createAndShowInterstitialAd() => InterstitialAd.load(
        adUnitId: _interstitialAdUnitID,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            debugPrint('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
            if (_interstitialAd == null) {
              debugPrint(
                  'Warning: attempt to show interstitial before loaded.');
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
