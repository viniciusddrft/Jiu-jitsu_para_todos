import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiu_jitsu_para_todos/src/modules/settings/view/components/body_settings_widget.dart';
import 'package:jiu_jitsu_para_todos/src/shared/appbar_gradient/appbar_gradient.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: AppBarGradient(),
        title: Text('title_appbar_settings_page'.tr(),
            style: TextStyle(fontFamily: 'YatraOne')),
      ),
      backgroundColor: Color(0xff202848),
      bottomNavigationBar: Container(
        height: 60.h,
        child: Center(
          child: Text(
            'text_version'.tr() + ' 2.0.7',
            style: TextStyle(fontSize: 16.sp, color: Colors.grey[700]),
          ),
        ),
      ),
      body: BodySettings(
        locale: context.locale,
      ),
    );
  }
}
