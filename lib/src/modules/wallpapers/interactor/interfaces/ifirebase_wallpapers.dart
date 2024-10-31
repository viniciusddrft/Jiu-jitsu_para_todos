import 'package:jiu_jitsu_para_todos/src/modules/wallpapers/interactor/wallpaper_state.dart';

abstract interface class IFirebaseWallpapers {
  Future<WallpaperState> loadWallpapers();
}
