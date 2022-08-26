class WallpaperModel {
  final String url;

  const WallpaperModel({
    required this.url,
  });

  WallpaperModel.fromJson(Map<String, String> json) : url = json['url']!;
}
