import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiu_jitsu_para_todos/src/modules/wallpapers/controller/wallpapers_controller.dart';
import 'package:jiu_jitsu_para_todos/src/shared/admob/controller/admob_controller.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';
import 'package:permission_handler/permission_handler.dart';

class DetailsImage extends StatefulWidget {
  final String imageUrl;
  final int index;

  const DetailsImage({super.key, required this.imageUrl, required this.index});

  @override
  State<DetailsImage> createState() => _DetailsImageState();
}

class _DetailsImageState extends State<DetailsImage> {
  late final Size size = MediaQuery.of(context).size;

  @override
  void didChangeDependencies() {
    precacheImage(Image.network(widget.imageUrl).image, context);
    super.didChangeDependencies();
  }

  void onPressed() async {
    if (await Permission.storage.request().isGranted) {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) => FractionallySizedBox(
          heightFactor: 0.5,
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            backgroundColor: AppColors.background,
            title: Text(
              AppLocalizations.of(context)!.title_popup_wallpaper,
              style: GoogleFonts.ubuntu(),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      fixedSize: const Size(200, 50),
                      foregroundColor: Colors.white,
                      elevation: 7,
                      backgroundColor: AppColors.background,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      side: const BorderSide(color: Colors.white)),
                  onPressed: () =>
                      ControllerWallpapers.setWallpaper(widget.imageUrl, 1)
                          .then((bool isSetWallpaperSuccess) {
                    if (isSetWallpaperSuccess) {
                      AdmobController.of(context).showInterstitialAd();
                    }
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.text_popup_set_home,
                      style: GoogleFonts.yatraOne(fontSize: 16),
                    ),
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      fixedSize: const Size(200, 50),
                      foregroundColor: Colors.white,
                      elevation: 7,
                      backgroundColor: AppColors.background,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      side: const BorderSide(color: Colors.white)),
                  onPressed: () =>
                      ControllerWallpapers.setWallpaper(widget.imageUrl, 2)
                          .then((bool isSetWallpaperSuccess) {
                    if (isSetWallpaperSuccess) {
                      AdmobController.of(context).showInterstitialAd();
                    }
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.text_popup_set_block,
                      style: GoogleFonts.yatraOne(fontSize: 16),
                    ),
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      fixedSize: const Size(200, 50),
                      foregroundColor: Colors.white,
                      elevation: 7,
                      backgroundColor: AppColors.background,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      side: const BorderSide(color: Colors.white)),
                  onPressed: () =>
                      ControllerWallpapers.setWallpaper(widget.imageUrl, 3)
                          .then((bool isSetWallpaperSuccess) {
                    if (isSetWallpaperSuccess) {
                      AdmobController.of(context).showInterstitialAd();
                    }
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.text_popup_set_both,
                      style: GoogleFonts.yatraOne(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  AppLocalizations.of(context)!.text_cancel,
                  style: GoogleFonts.ubuntu(),
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.7,
            child: Hero(
              tag: 'logo${widget.index}',
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(widget.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          fixedSize: const Size(200, 50),
                          foregroundColor: Colors.white,
                          elevation: 7,
                          backgroundColor: AppColors.background,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          side: const BorderSide(color: Colors.white)),
                      onPressed: onPressed,
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!
                              .text_popup_save_wallpaper,
                          style: GoogleFonts.yatraOne(fontSize: 16),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
