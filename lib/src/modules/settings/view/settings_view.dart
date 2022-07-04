import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../shared/appbar_gradient/appbar_gradient.dart';
import '../../../shared/themes/app_colors.dart';

import 'components/body_settings_widget.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});
  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
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
            '${AppLocalizations.of(context)!.text_version} 2.3.0',
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
        ),
      ),
      body: const BodySettings(),
    );
  }
}
