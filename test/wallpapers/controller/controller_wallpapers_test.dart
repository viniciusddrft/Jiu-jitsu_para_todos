import 'package:flutter_test/flutter_test.dart';
import 'package:jiu_jitsu_para_todos/src/modules/wallpapers/controller/wallpapers_controller.dart';

void main() {
  /*
    TEST README

    this test checks whether the driver is able to return all image paths
  */

  test('should return the url of the api images', () async {
    final ControllerWallpapers controllerWallpapers = ControllerWallpapers();
    await controllerWallpapers.loadWallpapers();

    expect(controllerWallpapers.wallpapers.isNotEmpty, true);
  });
}
