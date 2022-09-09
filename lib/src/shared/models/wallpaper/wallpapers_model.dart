class WallpaperModel {
  final String url;

  WallpaperModel.fromJson(Map<String, String> json) : url = json['url']!;
}
