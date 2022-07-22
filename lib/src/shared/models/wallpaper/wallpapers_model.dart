class WallpaperModel {
  final String url;

  const WallpaperModel({
    required this.url,
  });

  WallpaperModel.fromJson(Map<String, Object> json)
      : url = json['url'] as String;
}
