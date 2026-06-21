import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jiu_jitsu_para_todos/src/modules/wallpapers/interactor/interfaces/ifirebase_wallpapers.dart';
import 'package:jiu_jitsu_para_todos/src/modules/wallpapers/interactor/wallpaper_entity.dart';
import 'package:jiu_jitsu_para_todos/src/modules/wallpapers/interactor/wallpaper_state.dart';
import 'adapters/wallpapers_adapter.dart';

class FirebaseWallpapersImpl implements IFirebaseWallpapers {
  List<WallpaperEntity>? _cache;

  @override
  Future<WallpaperState> loadWallpapers({bool forceRefresh = false}) async {
    final cached = _cache;
    if (!forceRefresh && cached != null) {
      return WallpaperSuccess(cached);
    }
    try {
      final questionsRef = FirebaseFirestore.instance
          .collection('wallpapers')
          .withConverter<WallpaperEntity>(
            fromFirestore: (snapshots, _) =>
                WallpaperAdapter.fromJson(snapshots.data()!),
            toFirestore: (question, _) => WallpaperAdapter.toJson(question),
          );

      final QuerySnapshot querySnapshot =
          await questionsRef.get().timeout(const Duration(seconds: 30));

      final List<WallpaperEntity> wallpapers = List<WallpaperEntity>.from(
          querySnapshot.docs.map((doc) => doc.data()));

      _cache = wallpapers;
      return WallpaperSuccess(wallpapers);
    } catch (e) {
      return const WallpaperFailed();
    }
  }
}
