import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/shared/admob/controller/admob_controller.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Basicrules extends StatefulWidget {
  const Basicrules({Key? key}) : super(key: key);
  @override
  _BasicrulesState createState() => _BasicrulesState();
}

class _BasicrulesState extends State<Basicrules> {
  bool _loadingAnchoredBanner = false;
  final ValueNotifier<AdWidget?> _adWidget = ValueNotifier<AdWidget?>(null);

  @override
  void dispose() {
    _adWidget.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (!_loadingAnchoredBanner) {
      Admob.createAnchoredBanner(context).then((BannerAd? banner) {
        if (banner != null) {
          _adWidget.value = AdWidget(key: UniqueKey(), ad: banner..load());
          Admob.heightAnchoredBanner = banner.size.height;
          Admob.widthAnchoredBanner = banner.size.width;
        }
      }).whenComplete(() => _loadingAnchoredBanner = true);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          AppLocalizations.of(context)!.title_appbar_basic_rules_page,
          style: TextStyle(fontFamily: 'YatraOne', color: Colors.grey[700]),
        ),
      ),
      backgroundColor: AppColors.background,
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: _adWidget,
        builder: (BuildContext context, AdWidget? value, Widget? child) =>
            _loadingAnchoredBanner == true
                ? SizedBox(
                    height: Admob.heightAnchoredBanner.toDouble(),
                    width: Admob.widthAnchoredBanner.toDouble(),
                    child: value,
                  )
                : Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    color: Colors.transparent,
                  ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text(
                      AppLocalizations.of(context)!.text_overview_title,
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text(
                      AppLocalizations.of(context)!.text_overview,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text(
                      AppLocalizations.of(context)!.text_scores_title,
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text(
                      AppLocalizations.of(context)!.text_scores,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text(
                      AppLocalizations.of(context)!
                          .text_moves_that_gives_2_scores_title,
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text(
                      AppLocalizations.of(context)!.text_throws,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    Text(
                      AppLocalizations.of(context)!.text_knee_in_belly,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    Text(
                      AppLocalizations.of(context)!.text_sweep,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text(
                      AppLocalizations.of(context)!
                          .text_moves_that_gives_3_scores_title,
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text(
                      AppLocalizations.of(context)!
                          .text_moves_that_gives_3_scores,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    Text(
                      AppLocalizations.of(context)!.text_guard_pass,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text(
                      AppLocalizations.of(context)!
                          .text_moves_that_gives_4_scores_title,
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text(
                      AppLocalizations.of(context)!.text_mount,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    Text(
                      AppLocalizations.of(context)!.text_backward_grip,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text(
                      AppLocalizations.of(context)!
                          .text_advantage_and_penalties_title,
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text(
                      AppLocalizations.of(context)!
                          .text_advantage_and_penalties,
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
