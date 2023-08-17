import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../shared/l10n/locale_app.dart';
import '../../../shared/themes/app_icons_languages_path.dart';

class SettingsInterector {
  final _localeAppNotifier = Modular.get<LocaleInterector>();
  final iconPath = ValueNotifier<String?>(null);

  void loadLanguage() {
    if (_localeAppNotifier.value.countryCode!.toLowerCase() == 'us') {
      iconPath.value = AppIconsLanguages.unitedStates;
    } else if (_localeAppNotifier.value.countryCode!.toLowerCase() == 'br') {
      iconPath.value = AppIconsLanguages.brasil;
    }
  }

  void saveLanguage(Map<String, Object> data) {
    iconPath.value = data['icon'] as String;
    _localeAppNotifier.changeLocale(data['locale'] as Locale);
  }

  void dispose() {
    iconPath.dispose();
  }
}
