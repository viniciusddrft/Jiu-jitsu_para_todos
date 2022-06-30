class WallpaperModel {
  final String url;

  const WallpaperModel({
    required this.url,
  });

  WallpaperModel.fromJson(Map<String, dynamic> json) : url = json['url'];
}

const List<WallpaperModel> allImages = [
  WallpaperModel(url: 'assets/images/wallpapers/1.jpg'),
  WallpaperModel(url: 'assets/images/wallpapers/2.jpg'),
  WallpaperModel(url: 'assets/images/wallpapers/3.jpg'),
  WallpaperModel(url: 'assets/images/wallpapers/4.jpg'),
  WallpaperModel(url: 'assets/images/wallpapers/5.jpeg'),
  WallpaperModel(url: 'assets/images/wallpapers/6.png'),
  WallpaperModel(url: 'assets/images/wallpapers/7.png'),
  WallpaperModel(url: 'assets/images/wallpapers/8.png'),
  WallpaperModel(url: 'assets/images/wallpapers/9.png'),
  WallpaperModel(url: 'assets/images/wallpapers/10.png'),
  WallpaperModel(url: 'assets/images/wallpapers/11.png'),
  WallpaperModel(url: 'assets/images/wallpapers/12.png'),
  WallpaperModel(url: 'assets/images/wallpapers/13.png'),
  WallpaperModel(url: 'assets/images/wallpapers/14.png'),
  WallpaperModel(url: 'assets/images/wallpapers/15.png'),
  WallpaperModel(url: 'assets/images/wallpapers/16.png'),
  WallpaperModel(url: 'assets/images/wallpapers/17.png'),
  WallpaperModel(url: 'assets/images/wallpapers/18.png'),
  WallpaperModel(url: 'assets/images/wallpapers/19.png'),
];
