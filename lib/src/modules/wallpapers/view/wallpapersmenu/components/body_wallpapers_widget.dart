import 'package:flutter/material.dart';

import '../../../controller/wallpapers_controller.dart';

class BodyWallpalers extends StatefulWidget {
  const BodyWallpalers({super.key});
  @override
  State<BodyWallpalers> createState() => _BodyWallpalersState();
}

class _BodyWallpalersState extends State<BodyWallpalers> {
  final ControllerWallpapers _controllerWallpapers = ControllerWallpapers();

  late final Size size;

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _controllerWallpapers.loadWallpapers(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) => (snapshot
                  .connectionState ==
              ConnectionState.done)
          ? SizedBox(
              height: size.height,
              width: size.width,
              child: GridView.builder(
                itemCount: _controllerWallpapers.wallpapers.length,
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
                      context, '/DetailsImage', arguments: <String, dynamic>{
                    'imageUrl':
                        _controllerWallpapers.wallpapers.toList()[index].url,
                    'index': index
                  }),
                  child: Hero(
                    tag: 'logo$index',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        _controllerWallpapers.wallpapers.toList()[index].url,
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
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
