import 'package:flutter/material.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobNativeAd extends StatefulWidget {
  final String factoryId;
  final String adUnitId;
  final AdRequest? adRequest;
  final NativeAdOptions? nativeAdOptions;
  const AdmobNativeAd(
      {required this.factoryId,
      required this.adUnitId,
      this.adRequest,
      this.nativeAdOptions,
      super.key});

  @override
  State<AdmobNativeAd> createState() => _AdmobNativeAdState();
}

class _AdmobNativeAdState extends State<AdmobNativeAd> {
  late final NativeAd _nativeAd;
  final ValueNotifier<bool> _isAdLoaded = ValueNotifier<bool>(false);

  @override
  void initState() {
    _nativeAd = NativeAd(
      adUnitId: widget.adUnitId,
      factoryId: widget.factoryId,
      request: widget.adRequest ?? const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (_) => _isAdLoaded.value = true,
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          debugPrint(
              'Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
      nativeAdOptions: widget.nativeAdOptions,
    );

    _nativeAd.load();
    super.initState();
  }

  @override
  void dispose() {
    _nativeAd.dispose();
    _isAdLoaded.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _isAdLoaded,
      builder: (BuildContext context, bool value, Widget? child) =>
          _isAdLoaded.value
              ? AdWidget(
                  ad: _nativeAd,
                )
              : Stack(
                  children: const [
                    Center(child: Text('Ad')),
                    Center(child: CircularProgressIndicator()),
                  ],
                ),
    );
  }
}
