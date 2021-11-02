import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/shared/admob/controller/admob_controller.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JiujitsuinBrazil extends StatefulWidget {
  const JiujitsuinBrazil();
  @override
  _JiujitsuinBrazilState createState() => _JiujitsuinBrazilState();
}

class _JiujitsuinBrazilState extends State<JiujitsuinBrazil> {
  bool _loadingAnchoredBanner = false;
  final ValueNotifier<AdWidget?> _adWidget = ValueNotifier<AdWidget?>(null);

  @override
  void dispose() {
    _adWidget.dispose();
    super.dispose();
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'title_appbar_jiujitsu_in_brazil_page'.tr(),
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
                      'text_jiujitsu_in_brazil_paragraph1'.tr(),
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    Text(
                      'text_jiujitsu_in_brazil_paragraph2'.tr(),
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    Text(
                      'text_jiujitsu_in_brazil_paragraph3'.tr(),
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
