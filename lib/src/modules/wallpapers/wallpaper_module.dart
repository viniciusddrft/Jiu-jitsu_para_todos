import 'package:flutter_modular/flutter_modular.dart';
import 'data/firebase_wallpapers_impl_.dart';
import 'interactor/interfaces/ifirebase_wallpapers.dart';
import 'interactor/wallpaper_interactor.dart';
import 'ui/details_image_page.dart';
import 'ui/wallpapers_page.dart';

class WallpaperModule extends Module {
  @override
  void binds(i) {
    i.add(WallpaperInteractor.new);
    i.addSingleton<IFirebaseWallpapers>(FirebaseWallpapersImpl.new);
  }

  @override
  void routes(r) {
    r.child('/wallpapers',
        child: (context) => const WallpapersPage(),
        transition: TransitionType.rightToLeft);
    r.child(
      '/detailsimage',
      child: (context) => DetailsImagePage(
        wallpapers: r.args.data['wallpapers'],
        initialIndex: r.args.data['index'],
      ),
    );
  }
}
