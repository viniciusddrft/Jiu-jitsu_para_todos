import 'package:jiu_jitsu_para_todos/src/modules/wallpapers/interector/wallpaper_state.dart';

abstract interface class IFirebaseWallpapers {
  Future<WallpaperState> loadWallpapers();
}
