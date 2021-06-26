import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiu_jitsu_para_todos/src/shared/admob/controller/admob_controller.dart';
import 'package:jiu_jitsu_para_todos/src/shared/screen_size_for_ad_banner/screen_size_for_ab_Banner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:easy_localization/easy_localization.dart';

class Basicrules extends StatefulWidget {
  @override
  _BasicrulesState createState() => _BasicrulesState();
}

class _BasicrulesState extends State<Basicrules> {
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
          'title_appbar_basic_rules_page'.tr(),
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
                      'text_overview_title'.tr(),
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text(
                      'text_overview'.tr(),
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text(
                      'text_scores_title'.tr(),
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text(
                      'text_scores'.tr(),
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text(
                      'text_moves_that_gives_2_scores_title'.tr(),
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text(
                      'text_throws'.tr(),
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    Text(
                      'text_knee_in_belly'.tr(),
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    Text(
                      'text_sweep'.tr(),
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text(
                      'text_moves_that_gives_3_scores_title'.tr(),
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text(
                      'text_moves_that_gives_3_scores'.tr(),
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    Text(
                      'text_guard_pass'.tr(),
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text(
                      'text_moves_that_gives_4_scores_title'.tr(),
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text(
                      'text_mount'.tr(),
                      style: TextStyle(fontSize: 15.sp),
                    ),
                    Text(
                      'text_backward_grip'.tr(),
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text(
                      'text_advantage_and_penalties_title'.tr(),
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text(
                      'text_advantage_and_penalties'.tr(),
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
