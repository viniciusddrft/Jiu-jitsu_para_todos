import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/controllers/wallpapers/wallpapers_controller.dart';
import 'package:jiu_jitsu_para_todos/src/views/wallpapers/details_image_view.dart';

class BodyWallpalers extends StatefulWidget {
  @override
  _BodyWallpalersState createState() => _BodyWallpalersState();
}

class _BodyWallpalersState extends State<BodyWallpalers> {
  ControllerWallpapers controllerwallpapers = ControllerWallpapers();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return RawMaterialButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsImage(
                      imagePath:
                          controllerwallpapers.images.toList()[index].imagePath,
                      index: index,
                    ),
                  ),
                );
              },
              child: Hero(
                tag: 'logo$index',
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage(controllerwallpapers.images
                          .toList()[index]
                          .imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: controllerwallpapers.images.length,
        ),
      ),
    );
  }
}
