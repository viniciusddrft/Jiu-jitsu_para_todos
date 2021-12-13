import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jiu_jitsu_para_todos/core/locale/locale_app.dart';
import 'package:jiu_jitsu_para_todos/src/shared/launch_link/launch_link.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_icons_languages_path.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BodySettings extends StatefulWidget {
  const BodySettings({Key? key}) : super(key: key);
  @override
  _BodySettingsState createState() => _BodySettingsState();
}

class _BodySettingsState extends State<BodySettings> with OpenLink {
  final InAppReview _inAppReview = InAppReview.instance;

  final ValueNotifier<String?> _iconPath = ValueNotifier<String?>(null);

  List<Map<String, dynamic>> _allLocales() {
    return [
      {
        'locale': const Locale('pt', 'BR'),
        'icon': AppIconsLanguages.brasil,
        'text': AppLocalizations.of(context)!.text_brazilian_portuguese
      },
      {
        'locale': const Locale('en', 'US'),
        'icon': AppIconsLanguages.unitedStates,
        'text': AppLocalizations.of(context)!.text_english_united_states
      },
    ];
  }

  List<Map<String, dynamic>> get allLocales => _allLocales();

  @override
  void initState() {
    if (LocaleApp.localeApp.value == const Locale('en', 'US')) {
      _iconPath.value = AppIconsLanguages.unitedStates;
    } else if (LocaleApp.localeApp.value == const Locale('pt', 'BR')) {
      _iconPath.value = AppIconsLanguages.brasil;
    }
    super.initState();
  }

  @override
  void dispose() {
    _iconPath.dispose();
    super.dispose();
  }

  void _changeCredits() => Navigator.pushNamed(context, '/Credits');

//------------------------------------------------------------------------------
  Future<void> _changeLanguageMenu() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          backgroundColor: AppColors.background,
          scrollable: true,
          title:
              Text(AppLocalizations.of(context)!.button_language_settings_page),
          content: SizedBox(
            width: MediaQuery.of(context).size.width / 1.4,
            height: MediaQuery.of(context).size.height / 2.4,
            child: ListView.builder(
              itemCount: allLocales.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(top: 16.h, left: 10.w, right: 10.w),
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
                  onPressed: () {
                    _iconPath.value = allLocales[index]['icon'];
                    LocaleApp.localeApp.value = allLocales[index]['locale'];
                    SharedPreferences.getInstance().then(
                      (value) => value.setString(
                        'locale',
                        allLocales[index]['locale'].toString(),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(allLocales[index]['text']),
                        Image.asset(
                          allLocales[index]['icon'],
                          width: 50.w,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(AppLocalizations.of(context)!.text_cancel))
          ],
        );
      },
    );
  }

  //--------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
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
                child: SizedBox(
                  height: 155.h,
                  width: MediaQuery.of(context).size.width / 1.15,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20.sp, bottom: 35.sp),
                        child: Text(
                          AppLocalizations.of(context)!
                              .button_language_settings_page,
                          style: TextStyle(fontSize: 20.sp),
                        ),
                      ),
                      SizedBox(
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
                                  AppLocalizations.of(context)!
                                      .button_language_settings_page,
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                                ValueListenableBuilder(
                                  valueListenable: _iconPath,
                                  builder: (BuildContext context, String? value,
                                          Widget? child) =>
                                      Image.asset(
                                    value!,
                                    width: 40.w,
                                  ),
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
              child: SizedBox(
                height: 240.h,
                width: MediaQuery.of(context).size.width / 1.15,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20.sp, bottom: 35.sp),
                      child: Text(
                        AppLocalizations.of(context)!.text_contact,
                        style: TextStyle(fontSize: 20.sp),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 35.sp),
                      child: SizedBox(
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
                          onPressed: () => openLink(
                              'mailto:Jiu-jitsu_para_todos@protonmail.com'),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'E-mail',
                                style: TextStyle(fontSize: 16.sp),
                              ),
                              const Icon(Icons.mail)
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
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
                        onPressed: () => openLink(
                            'https://www.facebook.com/Jiujitsuparatodos2021/'),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Facebook',
                              style: TextStyle(fontSize: 16.sp),
                            ),
                            const Icon(Icons.facebook)
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
              child: SizedBox(
                height: 240.h,
                width: MediaQuery.of(context).size.width / 1.15,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20.sp, bottom: 35.sp),
                      child: Text(
                        AppLocalizations.of(context)!.text_about_the_app,
                        style: TextStyle(fontSize: 20.sp),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 35.sp),
                      child: SizedBox(
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
                                AppLocalizations.of(context)!.text_rate_the_app,
                                style: TextStyle(fontSize: 16.sp),
                              ),
                              const Icon(Icons.rate_review_outlined)
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
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
                            AppLocalizations.of(context)!
                                .button_credits_settings_page,
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
