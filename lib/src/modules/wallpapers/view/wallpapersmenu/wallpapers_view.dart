import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../shared/appbar_gradient/appbar_gradient.dart';
import '../../../../shared/themes/app_colors.dart';
import 'components/body_wallpapers_widget.dart';

class WallpapersView extends StatelessWidget {
  const WallpapersView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const AppBarGradient(),
        title: Text(AppLocalizations.of(context)!.title_appbar_wallpapers,
            style: const TextStyle(fontFamily: 'YatraOne')),
      ),
      backgroundColor: AppColors.background,
      body: const BodyWallpalers(),
    );
  }
}
