import 'package:flutter/widgets.dart';
import 'package:jiu_jitsu_para_todos/src/modules/wallpapers/interactor/wallpaper_state.dart';
import 'interfaces/ifirebase_wallpapers.dart';

class WallpaperInteractor extends ValueNotifier<WallpaperState> {
  WallpaperInteractor({required this.firebaseWallpapers})
      : super(const WallpaperLoading());

  final IFirebaseWallpapers firebaseWallpapers;

  void loadWallpapers() async {
    value = const WallpaperLoading();
    final newState = await firebaseWallpapers.loadWallpapers();
    value = newState;
  }
}
