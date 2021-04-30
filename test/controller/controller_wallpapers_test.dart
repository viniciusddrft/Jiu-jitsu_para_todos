import 'package:flutter_test/flutter_test.dart';
import 'package:jiu_jitsu_para_todos/src/controllers/wallpapers/wallpapers_controller.dart';

main() {
  /*
    TEST README

    this test checks whether the driver is able to return all image paths
  */
  ControllerWallpapers _controllerWallpapers = ControllerWallpapers();

  List<String> _allPathsImages = [
    'assets/images/wallpapers/jonathan-borba-YcrcG17Kjmg-unsplash.jpg',
    'assets/images/wallpapers/jonathan-borba-Yf1SegAI84o-unsplash.jpg',
    'assets/images/wallpapers/mma-1575855_960_720.jpg',
    'assets/images/wallpapers/jiu-jitsu-5641080_1280.jpg',
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
