import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiu_jitsu_para_todos/src/shared/admob/controller/admob_controller.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jiu_jitsu_para_todos/src/shared/screen_size_for_ad_banner/screen_size_for_ab_Banner.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class Cbjjrules extends StatefulWidget {
  @override
  _CbjjrulesState createState() => _CbjjrulesState();
}

class _CbjjrulesState extends State<Cbjjrules> {
  Future<void> _launchLink(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceWebView: false,
        forceSafariVC: false,
      );
    } else {}
  }

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
          'title_appbar_cbjj_rules_page'.tr(),
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
                            backgroundColor: Color(0xff202848),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            side: BorderSide(color: Colors.white)),
                        onPressed: () =>
                            _launchLink('https://cbjj.com.br/books-videos'),
                        child: Center(
                          child: Text('text_button_cbjj'.tr()),
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
