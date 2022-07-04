import '../../../shared/models/wallpaper/wallpapers_model.dart';
import '../../../shared/repositories/repository_api.dart';

class ControllerWallpapers {
  final RepositoryApi _repositoryApi = RepositoryApi();

  Future<void> loadWallpapers() async =>
      wallpapers = await _repositoryApi.getWallpapers();

  late final List<WallpaperModel> wallpapers;
}
