import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jiu_jitsu_para_todos/src/features/wallpapers/interector/interfaces/ifirebase_wallpapers.dart';
import 'package:jiu_jitsu_para_todos/src/features/wallpapers/interector/wallpaper_entity.dart';
import 'package:jiu_jitsu_para_todos/src/features/wallpapers/interector/wallpaper_state.dart';

import 'adapters/wallpapers_adapter.dart';

class FirebaseWallpapersImpl implements IFirebaseWallpapers {
  @override
  Future<WallpaperState> loadWallpapers() async {
    try {
      final questionsRef = FirebaseFirestore.instance
          .collection('wallpapers')
          .withConverter<WallpaperEntity>(
            fromFirestore: (snapshots, _) =>
                WallpaperAdapter.fromJson(snapshots.data()!),
            toFirestore: (question, _) => WallpaperAdapter.toJson(question),
          );

      final QuerySnapshot querySnapshot = await questionsRef.get();

      final List<WallpaperEntity> wallpapers = List<WallpaperEntity>.from(
          querySnapshot.docs.map((doc) => doc.data()));

      return WallpaperSuccess(wallpapers);
    } catch (e) {
      return const WallpaperFailed();
    }
  }
}
