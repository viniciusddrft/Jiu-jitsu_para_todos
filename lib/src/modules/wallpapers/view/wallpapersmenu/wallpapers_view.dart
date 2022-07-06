import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../shared/appbar_gradient/appbar_gradient.dart';
import '../../../../shared/themes/app_colors.dart';
import '../../controller/wallpapers_controller.dart';

class WallpapersView extends StatefulWidget {
  const WallpapersView({super.key});

  @override
  State<WallpapersView> createState() => _WallpapersViewState();
}

class _WallpapersViewState extends State<WallpapersView> {
  final ControllerWallpapers _controllerWallpapers = ControllerWallpapers();

  late final Size size;

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const AppBarGradient(),
        title: Text(AppLocalizations.of(context)!.title_appbar_wallpapers,
            style: const TextStyle(fontFamily: 'YatraOne')),
      ),
      backgroundColor: AppColors.background,
      body: FutureBuilder(
        future: _controllerWallpapers.loadWallpapers(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) =>
            (snapshot.connectionState == ConnectionState.done)
                ? GridView.builder(
                    itemCount: _controllerWallpapers.wallpapers.length,
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
                          context, '/DetailsImage',
                          arguments: <String, dynamic>{
                            'imageUrl': _controllerWallpapers.wallpapers
                                .toList()[index]
                                .url,
                            'index': index
                          }),
                      child: Hero(
                        tag: 'logo$index',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            _controllerWallpapers.wallpapers
                                .toList()[index]
                                .url,
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
