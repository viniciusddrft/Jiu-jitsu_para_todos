import 'package:flutter/widgets.dart';
import 'package:jiu_jitsu_para_todos/src/features/wallpapers/interector/wallpaper_state.dart';

import 'interfaces/ifirebase_wallpapers.dart';

class WallpaperInteractor extends ValueNotifier<WallpaperState> {
  WallpaperInteractor({required this.firebaseWallpapers})
      : super(WallpaperLoading());

  final IFirebaseWallpapers firebaseWallpapers;

  void loadWallpapers() async {
    value = WallpaperLoading();
    final newState = await firebaseWallpapers.loadWallpapers();
    value = newState;
  }
}
