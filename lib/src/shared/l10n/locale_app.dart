import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../plugins/local_storage/interface/local_storage_interface.dart';

class LocaleInterector extends ValueNotifier<Locale> {
  final ILocalStorage _localStorage;

  LocaleInterector(this._localStorage) : super(const Locale('en', 'Us'));

  void getLocalePreference() =>
      _localStorage.getValue<String>('locale').then((String? preference) {
        if (preference != null) {
          value = Locale(preference.split('_')[0], preference.split('_')[1]);
        } else {
          value = AppLocalizations.supportedLocales.contains(Locale(
                  Intl.systemLocale.split('_')[0],
                  Intl.systemLocale.split('_')[1]))
              ? Locale(
                  Intl.systemLocale.split('_')[0],
                  Intl.systemLocale.split('_')[1],
                )
              : const Locale('en', 'Us');
        }
      });

  void changeLocale(Locale newLocale) {
    value = newLocale;
    _localStorage.saveValue<String>('locale', value.toString());
  }
}
