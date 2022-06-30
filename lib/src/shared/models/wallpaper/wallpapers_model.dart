class WallpaperModel {
  final String url;

  const WallpaperModel({
    required this.url,
  });

  WallpaperModel.fromJson(Map<String, dynamic> json) : url = json['url'];
}
