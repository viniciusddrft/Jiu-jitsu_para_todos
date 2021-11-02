import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/shared/animated_page_route_builder/my_transition_elatic_out.dart';
import 'package:jiu_jitsu_para_todos/src/modules/credits/view/credits_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:jiu_jitsu_para_todos/src/shared/launch_link/launch_link.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_icons_languages_path.dart';
import 'package:in_app_review/in_app_review.dart';

class BodySettings extends StatefulWidget {
  final Locale locale;
  const BodySettings({required this.locale});
  @override
  _BodySettingsState createState() => _BodySettingsState();
}

class _BodySettingsState extends State<BodySettings> {
  final InAppReview _inAppReview = InAppReview.instance;

  late String _iconPath;

  static List<Map<String, dynamic>> _allLocales = [
    {
      'locale': const Locale('pt', 'BR'),
      'icon': AppIconsLanguages.brasil,
      'text': 'text_brazilian_portuguese'.tr()
    },
    {
      'locale': const Locale('en', 'US'),
      'icon': AppIconsLanguages.unitedStates,
      'text': 'text_english_united_states'.tr()
    },
  ];

  @override
  void initState() {
    if (widget.locale == Locale('en', 'US'))
      _iconPath = AppIconsLanguages.unitedStates;
    else if (widget.locale == Locale('pt', 'BR'))
      _iconPath = AppIconsLanguages.brasil;
    super.initState();
  }

//------------------------------------------------------------------------------
  void _changeCredits() => Navigator.of(context).push(MyTransitionElasticOut(
      route: CreditsView(), duration: Duration(milliseconds: 500)));
//------------------------------------------------------------------------------
  Future<void> _noticeAndChangeLanguage(Locale locale) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(10),
          backgroundColor: AppColors.background,
          scrollable: true,
          content: Container(
            child: Text('text_notice_popup'.tr()),
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.setLocale(locale);
                locale == Locale('pt', 'BR')
                    ? _iconPath = AppIconsLanguages.brasil
                    : _iconPath = AppIconsLanguages.unitedStates;
                Navigator.pop(context);
              },
              child: Text(
                'text_continue_popup'.tr(),
              ),
            ),
          ],
        );
      },
    );
  }

//------------------------------------------------------------------------------
  Future<void> _changeLanguageMenu() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(10),
          backgroundColor: AppColors.background,
          scrollable: true,
          content: Container(
            width: MediaQuery.of(context).size.width / 1.4,
            height: MediaQuery.of(context).size.height / 2,
            child: ListView.builder(
              itemCount: _allLocales.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    _noticeAndChangeLanguage(_allLocales[index]['locale']);
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_allLocales[index]['text']),
                        Image.asset(
                          _allLocales[index]['icon'],
                          width: 50.w,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  //--------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: AppColors.cardColor,
                child: Container(
                  height: 155.h,
                  width: MediaQuery.of(context).size.width / 1.15,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20.sp, bottom: 35.sp),
                        child: Text(
                          'button_language_settings_page'.tr(),
                          style: TextStyle(fontSize: 20.sp),
                        ),
                      ),
                      Container(
                        height: 50.h,
                        width: 200.w,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.background,
                            primary: Colors.white,
                            elevation: 7,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            side: const BorderSide(color: Colors.white),
                          ),
                          onPressed: _changeLanguageMenu,
                          child: Container(
                            color: Colors.transparent,
                            width: MediaQuery.of(context).size.width / 1.6,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'button_language_settings_page'.tr(),
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                                Image.asset(
                                  _iconPath,
                                  width: 40.w,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: AppColors.cardColor,
              child: Container(
                height: 240.h,
                width: MediaQuery.of(context).size.width / 1.15,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20.sp, bottom: 35.sp),
                      child: Text(
                        'text_contact'.tr(),
                        style: TextStyle(fontSize: 20.sp),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 35.sp),
                      child: Container(
                        height: 50.h,
                        width: 200.w,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.background,
                            primary: Colors.white,
                            elevation: 7,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            side: const BorderSide(color: Colors.white),
                          ),
                          onPressed: () => launchLink(
                              'mailto:Jiu-jitsu_para_todos@protonmail.com'),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'E-mail',
                                style: TextStyle(fontSize: 16.sp),
                              ),
                              Icon(Icons.mail)
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 50.h,
                      width: 200.w,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors.background,
                          primary: Colors.white,
                          elevation: 7,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          side: const BorderSide(color: Colors.white),
                        ),
                        onPressed: () => launchLink(
                            'https://www.facebook.com/Jiujitsuparatodos2021/'),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Facebook',
                              style: TextStyle(fontSize: 16.sp),
                            ),
                            Icon(Icons.facebook)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: AppColors.cardColor,
              child: Container(
                height: 240.h,
                width: MediaQuery.of(context).size.width / 1.15,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20.sp, bottom: 35.sp),
                      child: Text(
                        'text_about_the_app'.tr(),
                        style: TextStyle(fontSize: 20.sp),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 35.sp),
                      child: Container(
                        height: 50.h,
                        width: 200.w,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.background,
                            primary: Colors.white,
                            elevation: 7,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            side: const BorderSide(color: Colors.white),
                          ),
                          onPressed: () => _inAppReview.openStoreListing(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'text_rate_the_app'.tr(),
                                style: TextStyle(fontSize: 16.sp),
                              ),
                              Icon(Icons.rate_review_outlined)
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 50.h,
                      width: 200.w,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors.background,
                          primary: Colors.white,
                          elevation: 7,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          side: const BorderSide(color: Colors.white),
                        ),
                        onPressed: _changeCredits,
                        child: Center(
                          child: Text(
                            'button_credits_settings_page'.tr(),
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
