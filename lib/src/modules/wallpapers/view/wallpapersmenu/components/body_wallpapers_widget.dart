import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/modules/wallpapers/controller/wallpapers_controller.dart';
import 'package:jiu_jitsu_para_todos/src/modules/wallpapers/view/detailsimage/details_image_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BodyWallpalers extends StatefulWidget {
  const BodyWallpalers();
  @override
  _BodyWallpalersState createState() => _BodyWallpalersState();
}

class _BodyWallpalersState extends State<BodyWallpalers> {
  ControllerWallpapers _controllerWallpapers = ControllerWallpapers();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.sp,
          mainAxisSpacing: 10.sp,
        ),
        itemBuilder: (context, index) => RawMaterialButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsImage(
                imagePath:
                    _controllerWallpapers.images.toList()[index].imagePath,
                index: index,
              ),
            ),
          ),
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
