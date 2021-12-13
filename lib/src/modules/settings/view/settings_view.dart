import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/modules/settings/view/components/body_settings_widget.dart';
import 'package:jiu_jitsu_para_todos/src/shared/appbar_gradient/appbar_gradient.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);
  @override
  _SettingsViewState createState() => _SettingsViewState();
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
        height: 60.h,
        child: Center(
          child: Text(
            AppLocalizations.of(context)!.text_version + ' 2.1.9',
            style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
          ),
        ),
      ),
      body: const BodySettings(),
    );
  }
}
