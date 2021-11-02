import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/shared/admob/controller/admob_controller.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class Cbjjrules extends StatefulWidget {
  const Cbjjrules();
  @override
  _CbjjrulesState createState() => _CbjjrulesState();
}

class _CbjjrulesState extends State<Cbjjrules> {
  bool _loadingAnchoredBanner = false;
  final ValueNotifier<AdWidget?> _adWidget = ValueNotifier<AdWidget?>(null);

  @override
  void didChangeDependencies() {
    if (!_loadingAnchoredBanner)
      Admob.createAnchoredBanner(context).then((BannerAd? banner) {
        if (banner != null) {
          _adWidget.value = AdWidget(key: UniqueKey(), ad: banner..load());
          Admob.heightAnchoredBanner = banner.size.height;
          Admob.widthAnchoredBanner = banner.size.width;
        }
      })
        ..whenComplete(() => _loadingAnchoredBanner = true);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _adWidget.dispose();
    super.dispose();
  }

  Future<void> _launchLink(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: false, forceSafariVC: false);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'title_appbar_cbjj_rules_page'.tr(),
          style: TextStyle(fontFamily: 'YatraOne', color: Colors.grey[700]),
        ),
      ),
      backgroundColor: AppColors.background,
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: _adWidget,
        builder: (BuildContext context, AdWidget? value, Widget? child) =>
            _loadingAnchoredBanner == true
                ? Container(
                    height: Admob.heightAnchoredBanner.toDouble(),
                    width: Admob.widthAnchoredBanner.toDouble(),
                    child: value,
                  )
                : Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    color: Colors.transparent,
                  ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text(
                      'text_cbjj'.tr(),
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Container(
                      height: 50.h,
                      width: 200.w,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            elevation: 7,
                            primary: Colors.white,
                            backgroundColor: AppColors.background,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            side: BorderSide(color: Colors.white)),
                        onPressed: () =>
                            _launchLink('https://cbjj.com.br/books-videos'),
                        child: Center(
                          child: Text(
                            'text_button_cbjj'.tr(),
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
