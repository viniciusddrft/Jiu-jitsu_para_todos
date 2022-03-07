import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/modules/wallpapers/controller/wallpapers_controller.dart';

class BodyWallpalers extends StatefulWidget {
  const BodyWallpalers({Key? key}) : super(key: key);
  @override
  _BodyWallpalersState createState() => _BodyWallpalersState();
}

class _BodyWallpalersState extends State<BodyWallpalers> {
  final ControllerWallpapers _controllerWallpapers = ControllerWallpapers();

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return SizedBox(
      height: _size.height,
      width: _size.width,
      child: GridView.builder(
        padding: EdgeInsets.symmetric(
            horizontal: _size.width * 0.05, vertical: _size.height * 0.03),
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
