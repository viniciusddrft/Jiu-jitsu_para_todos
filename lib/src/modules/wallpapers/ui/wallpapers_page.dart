import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiu_jitsu_para_todos/src/modules/wallpapers/interactor/wallpaper_entity.dart';
import 'package:jiu_jitsu_para_todos/src/modules/wallpapers/interactor/wallpaper_interactor.dart';
import 'package:jiu_jitsu_para_todos/src/modules/wallpapers/interactor/wallpaper_state.dart';
import 'package:jiu_jitsu_para_todos/src/shared/components/admob_native_ad.dart';
import 'package:jiu_jitsu_para_todos/src/shared/l10n/app_localizations.dart';
import 'package:jiu_jitsu_para_todos/src/shared/plugins/admob/admob_interactor.dart';
import '../../../shared/components/app_bar_gradient.dart';
import '../../../shared/shimmer/shimmer_widget.dart';
import '../../../shared/themes/app_colors.dart';
import '../../../shared/themes/app_images.dart';

class WallpapersPage extends StatefulWidget {
  const WallpapersPage({super.key});

  @override
  State<WallpapersPage> createState() => _WallpapersViewState();
}

class _WallpapersViewState extends State<WallpapersPage> {
  final _wallpaperInteractor = Modular.get<WallpaperInteractor>();
  final admobInteractor = Modular.get<AdmobInteractor>();

  @override
  void initState() {
    _wallpaperInteractor.loadWallpapers();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    admobInteractor.createInterstitialAd();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const AppBarGradient(),
        title: Text(AppLocalizations.of(context)!.title_appbar_wallpapers,
            style: GoogleFonts.yatraOne()),
      ),
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        onRefresh: () async => _wallpaperInteractor.loadWallpapers(),
        child: ValueListenableBuilder(
          valueListenable: _wallpaperInteractor,
          builder: (context, value, child) =>
              switch (_wallpaperInteractor.value) {
            WallpaperLoading() => GridView.builder(
                itemCount: 18,
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                    vertical: size.height * 0.03),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) => ShimmerWidget(
                  width: 100,
                  height: 100,
                  shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            WallpaperFailed() => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.withoutInternet,
                      width: 200,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        'Sem internet',
                        style: TextStyle(fontSize: 24),
                      ),
                    )
                  ],
                ),
              ),
            WallpaperSuccess(
              wallpapers: final List<WallpaperEntity> wallpapers
            ) =>
              GridView.builder(
                itemCount: wallpapers.length,
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                    vertical: size.height * 0.03),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) => RawMaterialButton(
                  onPressed: () => Navigator.pushNamed(
                      context, '/wallpaper/detailsimage',
                      arguments: {
                        'index': index,
                        'imageUrl': wallpapers[index].url,
                      }),
                  child: Hero(
                    transitionOnUserGestures: true,
                    tag: 'logo$index',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        wallpapers[index].url,
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                        loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) =>
                            (loadingProgress == null)
                                ? child
                                : Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  ),
                      ),
                    ),
                  ),
                ),
              ),
          },
        ),
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

  @override
  void dispose() {
    _wallpaperInteractor.dispose();
    super.dispose();
  }
}
