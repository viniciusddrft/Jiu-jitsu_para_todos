import 'package:jiu_jitsu_para_todos/src/modules/wallpapers/interector/wallpaper_entity.dart';

class WallpaperAdapter {
  static WallpaperEntity fromJson(Map<String, dynamic> json) => WallpaperEntity(
        url: json['url'],
      );

  static Map<String, dynamic> toJson(WallpaperEntity wallpaperEntity) => {
        'url': wallpaperEntity.url,
      };
}
