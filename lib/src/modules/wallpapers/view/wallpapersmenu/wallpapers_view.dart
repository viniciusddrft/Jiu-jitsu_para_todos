import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/admob/controller/admob_controller.dart';
import '../../../../shared/appbar_gradient/appbar_gradient.dart';
import '../../../../shared/models/wallpaper/wallpapers_model.dart';
import '../../../../shared/themes/app_colors.dart';
import '../../controller/wallpapers_controller.dart';

class WallpapersView extends StatefulWidget {
  const WallpapersView({super.key});

  @override
  State<WallpapersView> createState() => _WallpapersViewState();
}

class _WallpapersViewState extends State<WallpapersView> {
  final ControllerWallpapers _controllerWallpapers = ControllerWallpapers();
  late final Future<List<WallpaperModel>> _loadWallpapers;
  late final Size size = MediaQuery.of(context).size;

  @override
  void initState() {
    _loadWallpapers = _controllerWallpapers.loadWallpapers();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    AdmobController.of(context).createInterstitialAd();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const AppBarGradient(),
        title: Text(AppLocalizations.of(context)!.title_appbar_wallpapers,
            style: GoogleFonts.yatraOne()),
      ),
      backgroundColor: AppColors.background,
      body: FutureBuilder(
        future: _loadWallpapers,
        builder: (BuildContext context,
                AsyncSnapshot<List<WallpaperModel>> snapshot) =>
            (snapshot.connectionState == ConnectionState.done)
                ? GridView.builder(
                    itemCount: snapshot.data!.length,
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.05,
                        vertical: size.height * 0.03),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) => RawMaterialButton(
                      onPressed: () => Navigator.pushNamed(
                          context, '/DetailsImage', arguments: <String, Object>{
                        'imageUrl': snapshot.data!.toList()[index].url,
                        'index': index
                      }),
                      child: Hero(
                        tag: 'logo$index',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            snapshot.data!.toList()[index].url,
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                            loadingBuilder: (BuildContext context, Widget child,
                                    ImageChunkEvent? loadingProgress) =>
                                (loadingProgress == null)
                                    ? child
                                    : Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
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
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
      ),
    );
  }
}
