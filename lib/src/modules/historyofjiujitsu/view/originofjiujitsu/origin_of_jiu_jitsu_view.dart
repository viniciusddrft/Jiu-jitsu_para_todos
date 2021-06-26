import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiu_jitsu_para_todos/src/shared/admob/controller/admob_controller.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:jiu_jitsu_para_todos/src/shared/screen_size_for_ad_banner/screen_size_for_ab_Banner.dart';

class OriginOfJiujitsu extends StatefulWidget {
  @override
  _OriginOfJiujitsuState createState() => _OriginOfJiujitsuState();
}

class _OriginOfJiujitsuState extends State<OriginOfJiujitsu> {
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
          'title_appbar_origin_of_jiujitsu_page'.tr(),
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
                      'text_origin_of_jiujitsu_paragraph1'.tr(),
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    Text(
                      'text_origin_of_jiujitsu_paragraph2'.tr(),
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    Text(
                      'text_origin_of_jiujitsu_paragraph3'.tr(),
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    Text(
                      'text_origin_of_jiujitsu_paragraph4'.tr(),
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    Text(
                      'text_origin_of_jiujitsu_paragraph5'.tr(),
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
