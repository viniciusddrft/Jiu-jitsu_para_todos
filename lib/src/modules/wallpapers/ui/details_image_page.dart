import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiu_jitsu_para_todos/src/shared/components/admob_native_ad.dart';
import 'package:jiu_jitsu_para_todos/src/shared/l10n/app_localizations.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../shared/plugins/admob/admob_interactor.dart';
import '../interactor/wallpaper_entity.dart';

class DetailsImagePage extends StatefulWidget {
  final List<WallpaperEntity> wallpapers;
  final int initialIndex;

  const DetailsImagePage(
      {super.key, required this.wallpapers, required this.initialIndex});

  @override
  State<DetailsImagePage> createState() => _DetailsImagePageState();
}

class _DetailsImagePageState extends State<DetailsImagePage> {
  final admobInteractor = Modular.get<AdmobInteractor>();
  late final PageController _pageController =
      PageController(initialPage: widget.initialIndex);
  late int _currentIndex = widget.initialIndex;
  bool _precached = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_precached) {
      _precached = true;
      _precacheAround(widget.initialIndex);
    }
  }

  // Pré-carrega a página atual e os vizinhos para a troca ficar suave.
  void _precacheAround(int index) {
    for (final i in [index, index - 1, index + 1]) {
      if (i >= 0 && i < widget.wallpapers.length) {
        precacheImage(NetworkImage(widget.wallpapers[i].url), context);
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _setWallpaper({required WallpaperTarget target}) {
    admobInteractor.showInterstitialAd();
    AsyncWallpaper.setWallpaper(
      WallpaperRequest(
        target: target,
        sourceType: WallpaperSourceType.url,
        source: widget.wallpapers[_currentIndex].url,
      ),
    ).then((result) {
      if (result.isSuccess) {
        _showDialogSuccess();
      }
    });
  }

  void _showDialogSuccess() => showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.text_popup_saved),
            backgroundColor: AppColors.background,
          );
        },
      );

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
                  onPressed: () => _setWallpaper(target: WallpaperTarget.home),
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
                  onPressed: () => _setWallpaper(target: WallpaperTarget.lock),
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
                  onPressed: () => _setWallpaper(target: WallpaperTarget.both),
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
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.wallpapers.length,
              onPageChanged: (i) {
                _currentIndex = i;
                _precacheAround(i);
              },
              itemBuilder: (context, i) => Hero(
                transitionOnUserGestures: true,
                tag: 'logo$i',
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  child: Image.network(
                    widget.wallpapers[i].url,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    loadingBuilder: (ctx, child, progress) => progress == null
                        ? child
                        : const Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.18,
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
