import 'package:flutter/material.dart';

import '../../../controller/wallpapers_controller.dart';

class BodyWallpalers extends StatefulWidget {
  const BodyWallpalers({super.key});
  @override
  State<BodyWallpalers> createState() => _BodyWallpalersState();
}

class _BodyWallpalersState extends State<BodyWallpalers> {
  final ControllerWallpapers _controllerWallpapers = ControllerWallpapers();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      width: size.width,
      child: GridView.builder(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05, vertical: size.height * 0.03),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) => RawMaterialButton(
          onPressed: () => Navigator.pushNamed(context, '/DetailsImage',
              arguments: <String, dynamic>{
                'imagePath':
                    _controllerWallpapers.images.toList()[index].imagePath,
                'index': index
              }),
          child: Hero(
            tag: 'logo$index',
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(
                      _controllerWallpapers.images.toList()[index].imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        itemCount: _controllerWallpapers.images.length,
      ),
    );
  }
}
