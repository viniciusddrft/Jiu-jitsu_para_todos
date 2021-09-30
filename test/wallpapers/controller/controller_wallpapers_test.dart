import 'package:flutter_test/flutter_test.dart';
import 'package:jiu_jitsu_para_todos/src/modules/wallpapers/controller/wallpapers_controller.dart';

main() {
  /*
    TEST README

    this test checks whether the driver is able to return all image paths
  */
  final ControllerWallpapers _controllerWallpapers = ControllerWallpapers();

  final List<String> _allPathsImages = [
    'assets/images/wallpapers/1.jpg',
    'assets/images/wallpapers/2.jpg',
    'assets/images/wallpapers/3.jpg',
    'assets/images/wallpapers/4.jpg',
    'assets/images/wallpapers/5.jpeg',
    'assets/images/wallpapers/6.png',
    'assets/images/wallpapers/7.png',
    'assets/images/wallpapers/8.png',
    'assets/images/wallpapers/9.png',
    'assets/images/wallpapers/10.png',
    'assets/images/wallpapers/11.png',
    'assets/images/wallpapers/12.png',
    'assets/images/wallpapers/13.png',
    'assets/images/wallpapers/14.png',
    'assets/images/wallpapers/15.png',
    'assets/images/wallpapers/16.png',
  ];
  test('deve retornar o caminho das images', () {
    List<String> _arrayTest = [];
    for (int _i = 0; _i != _controllerWallpapers.images.length; _i++) {
      //print(_controllerWallpapers.images[_i].imagePath);
      _arrayTest.add(_controllerWallpapers.images[_i].imagePath);
    }
    expect(_allPathsImages, _arrayTest);
  });
}
