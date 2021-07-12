import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiu_jitsu_para_todos/src/modules/wallpapers/view/wallpapersmenu/components/body_wallpapers_widget.dart';
import 'package:jiu_jitsu_para_todos/src/shared/appbar_gradient/appbar_gradient.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';

class WallpapersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: AppBarGradient(),
        title: Text('title_appbar_wallpapers'.tr(),
            style: TextStyle(fontFamily: 'YatraOne')),
      ),
      backgroundColor: AppColors.background,
      body: BodyWallpalers(),
    );
  }
}
