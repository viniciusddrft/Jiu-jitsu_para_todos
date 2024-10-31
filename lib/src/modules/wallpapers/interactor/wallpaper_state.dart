import 'package:jiu_jitsu_para_todos/src/modules/wallpapers/interactor/wallpaper_entity.dart';

sealed class WallpaperState {}

final class WallpaperFailed implements WallpaperState {
  const WallpaperFailed();
}

final class WallpaperSuccess implements WallpaperState {
  final List<WallpaperEntity> wallpapers;

  const WallpaperSuccess(this.wallpapers);
}

final class WallpaperLoading implements WallpaperState {
  const WallpaperLoading();
}
