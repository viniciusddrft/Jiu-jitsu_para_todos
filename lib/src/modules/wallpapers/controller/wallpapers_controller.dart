import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../shared/models/wallpaper/wallpapers_model.dart';
import '../../../shared/repositories/repository_api.dart';

class ControllerWallpapers {
  final RepositoryApi _repositoryApi = RepositoryApi();

  Future<List<WallpaperModel>> loadWallpapers() async =>
      await _repositoryApi.getWallpapers();

  static Future<bool?> setWallpaper(String url, int wallpaperLocation) async {
    if (await Permission.storage.request().isGranted) {
      return await AsyncWallpaper.setWallpaper(
          url: url, wallpaperLocation: wallpaperLocation);
    }
    return false;
  }
}
