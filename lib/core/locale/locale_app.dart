import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleApp {
  static ValueNotifier<Locale> localeApp = ValueNotifier<Locale>(
    AppLocalizations.supportedLocales.contains(Locale(
            Intl.systemLocale.split('_')[0], Intl.systemLocale.split('_')[1]))
        ? Locale(
            Intl.systemLocale.split('_')[0],
            Intl.systemLocale.split('_')[1],
          )
        : const Locale('en', 'Us'),
  );

  static void getLocalePreference() => SharedPreferences.getInstance().then(
        (value) {
          String? preference = value.getString('locale');
          if (preference != null) {
            localeApp.value =
                Locale(preference.split('_')[0], preference.split('_')[1]);
          }
        },
      );
}
