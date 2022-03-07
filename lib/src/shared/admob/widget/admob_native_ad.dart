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
      Key? key})
      : super(key: key);

  @override
  _AdmobNativeAdState createState() => _AdmobNativeAdState();
}

class _AdmobNativeAdState extends State<AdmobNativeAd> {
  late final NativeAd _nativeAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    _nativeAd = NativeAd(
      adUnitId: widget.adUnitId,
      factoryId: widget.factoryId,
      request: widget.adRequest ?? const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (_) => setState(() => _isAdLoaded = true),
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isAdLoaded
        ? AdWidget(
            ad: _nativeAd,
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
