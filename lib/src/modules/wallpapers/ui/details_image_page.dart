import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiu_jitsu_para_todos/src/shared/components/admob_native_ad.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../shared/plugins/admob/admob_interactor.dart';

class DetailsImagePage extends StatefulWidget {
  final String imageUrl;
  final int index;

  const DetailsImagePage(
      {super.key, required this.imageUrl, required this.index});

  @override
  State<DetailsImagePage> createState() => _DetailsImagePageState();
}

class _DetailsImagePageState extends State<DetailsImagePage> {
  final admobInteractor = Modular.get<AdmobInteractor>();

  @override
  void didChangeDependencies() {
    precacheImage(Image.network(widget.imageUrl).image, context);
    super.didChangeDependencies();
  }

  void setWallpaper({required int wallpaperLocation}) async {
    final isSetWallpaperSuccess = await AsyncWallpaper.setWallpaper(
        url: widget.imageUrl, wallpaperLocation: wallpaperLocation);

    if (isSetWallpaperSuccess) {
      showAd();
    }
  }

  void showAd() {
    Navigator.pop(context);
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) {
        Future.delayed(
            const Duration(seconds: 2), admobInteractor.showInterstitialAd);
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.text_popup_saved),
          backgroundColor: AppColors.background,
        );
      },
    );
  }

  void showDialogSetWallpaper() => showDialog<void>(
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
                  onPressed: () => setWallpaper(wallpaperLocation: 1),
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
                  onPressed: () => setWallpaper(wallpaperLocation: 2),
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
                  onPressed: () => setWallpaper(wallpaperLocation: 3),
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

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.7,
            child: Hero(
              transitionOnUserGestures: true,
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
            height: size.height * 0.2,
            child: Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    fixedSize: const Size(200, 50),
                    foregroundColor: Colors.white,
                    elevation: 7,
                    backgroundColor: AppColors.background,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    side: const BorderSide(color: Colors.white)),
                onPressed: () async {
                  final PermissionStatus status =
                      await Permission.storage.status;
                  if (status.isDenied) await Permission.storage.request();
                  showDialogSetWallpaper();
                },
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.text_popup_save_wallpaper,
                    style: GoogleFonts.yatraOne(fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 75,
        child: AdmobNativeAd(
          factoryId: 'listTile',
          adUnitId: admobInteractor.nativeAdUnitIDListTile,
        ),
      ),
    );
  }
}
