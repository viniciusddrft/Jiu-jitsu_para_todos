import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/locale/locale_app.dart';
import '../../../shared/appbar_gradient/appbar_gradient.dart';
import '../../../shared/launch_link/launch_link.dart';
import '../../../shared/themes/app_colors.dart';
import '../../../shared/themes/app_icons_languages_path.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});
  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> with OpenLink {
  late final Size size = MediaQuery.of(context).size;
  final ValueNotifier<String?> _iconPath = ValueNotifier<String?>(null);

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
  void didChangeDependencies() {
    precacheImage(Image.asset(AppIconsLanguages.unitedStates).image, context);
    precacheImage(Image.asset(AppIconsLanguages.brasil).image, context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _iconPath.dispose();
    super.dispose();
  }

  List<Map<String, Object>> _allLocales() => [
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

  List<Map<String, Object>> get allLocales => _allLocales();

  void _changeCredits() => Navigator.pushNamed(context, '/Credits');

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
            width: size.width * 0.7,
            height: size.height * 0.4,
            child: ListView.builder(
              itemCount: allLocales.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.02,
                    left: size.width * 0.02,
                    right: size.width * 0.02),
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
                    _iconPath.value = allLocales[index]['icon'] as String;
                    LocaleApp.localeApp.value =
                        allLocales[index]['locale'] as Locale;
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
                        Text(allLocales[index]['text'] as String),
                        Image.asset(
                          allLocales[index]['icon'] as String,
                          width: 50,
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
              child: Text(AppLocalizations.of(context)!.text_cancel),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const AppBarGradient(),
        title: Text(AppLocalizations.of(context)!.title_appbar_settings_page,
            style: const TextStyle(fontFamily: 'YatraOne')),
      ),
      backgroundColor: AppColors.background,
      bottomNavigationBar: SizedBox(
        height: 60,
        child: Center(
          child: Text(
            '${AppLocalizations.of(context)!.text_version} 2.5.0',
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
        ),
      ),
      body: SizedBox(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Spacer(),
            Flexible(
              flex: 15,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: AppColors.cardColor,
                child: SizedBox(
                  width: size.width * 0.85,
                  child: Column(
                    children: [
                      const Spacer(),
                      Flexible(
                        child: Text(
                          AppLocalizations.of(context)!
                              .button_language_settings_page,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      const Spacer(),
                      Flexible(
                        flex: 3,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            fixedSize: const Size(200, 50),
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!
                                      .button_language_settings_page,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                ValueListenableBuilder(
                                  valueListenable: _iconPath,
                                  builder: (BuildContext context, String? value,
                                          Widget? child) =>
                                      Image.asset(
                                    value!,
                                    width: 40,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 20,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: AppColors.cardColor,
                child: SizedBox(
                  width: size.width * 0.85,
                  child: Column(
                    children: [
                      const Spacer(),
                      Flexible(
                        child: Text(
                          AppLocalizations.of(context)!.text_contact,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      const Spacer(),
                      Flexible(
                        flex: 3,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            fixedSize: const Size(200, 50),
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
                            children: const [
                              Text(
                                'E-mail',
                                style: TextStyle(fontSize: 16),
                              ),
                              Icon(Icons.mail)
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Flexible(
                        flex: 3,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            fixedSize: const Size(200, 50),
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
                            children: const [
                              Text(
                                'Facebook',
                                style: TextStyle(fontSize: 16),
                              ),
                              Icon(Icons.facebook)
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 20,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: AppColors.cardColor,
                child: SizedBox(
                  width: size.width * 0.85,
                  child: Column(
                    children: [
                      const Spacer(),
                      Flexible(
                        child: Text(
                          AppLocalizations.of(context)!.text_about_the_app,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      const Spacer(),
                      Flexible(
                        flex: 3,
                        child: SizedBox(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              fixedSize: const Size(200, 50),
                              backgroundColor: AppColors.background,
                              primary: Colors.white,
                              elevation: 7,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              side: const BorderSide(color: Colors.white),
                            ),
                            onPressed: () => openLink(
                                'https://play.google.com/store/apps/details?id=com.jiu_jitsu_para_todos'),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!
                                      .text_rate_the_app,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const Icon(Icons.rate_review_outlined)
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Flexible(
                        flex: 3,
                        child: SizedBox(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              fixedSize: const Size(200, 50),
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
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
