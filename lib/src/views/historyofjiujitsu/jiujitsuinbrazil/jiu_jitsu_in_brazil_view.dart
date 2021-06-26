import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiu_jitsu_para_todos/src/controllers/admob/admob_controller.dart';
import 'package:jiu_jitsu_para_todos/src/shared/screen_size_for_ad_banner/screen_size_for_ab_Banner.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class JiujitsuinBrazil extends StatefulWidget {
  @override
  _JiujitsuinBrazilState createState() => _JiujitsuinBrazilState();
}

class _JiujitsuinBrazilState extends State<JiujitsuinBrazil> {
  @override
  void dispose() {
    Admob.disposeBanner();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'title_appbar_jiujitsu_in_brazil_page'.tr(),
          style: TextStyle(fontFamily: 'YatraOne', color: Colors.grey[700]),
        ),
      ),
      backgroundColor: Color(0xff202848),
      bottomNavigationBar: Container(
        height: screenSizeForAdBanner()
            ? 90
            : 60, //this is the space where I will render the ad
        child: AdWidget(
          key: UniqueKey(),
          ad: Admob.createBannerAd()..load(),
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
