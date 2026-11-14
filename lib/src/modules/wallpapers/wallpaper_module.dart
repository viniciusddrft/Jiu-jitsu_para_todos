import 'package:flutter_modular/flutter_modular.dart';
import '../../shared/transitions/app_transitions.dart';
import 'data/firebase_wallpapers_impl_.dart';
import 'interactor/interfaces/ifirebase_wallpapers.dart';
import 'interactor/wallpaper_interactor.dart';
import 'ui/details_image_page.dart';
import 'ui/wallpapers_page.dart';

final wallpaperModule = createModule(
  path: '/wallpaper',
  register: (c) => c
    ..add(WallpaperInteractor.new)
    ..addSingleton<IFirebaseWallpapers>(FirebaseWallpapersImpl.new)
    ..route('/wallpapers',
        child: (context, state) => const WallpapersPage(),
        transition: AppTransitions.rightToLeft)
    ..route('/detailsimage', child: (context, state) {
      final args = state.arguments as Map<String, dynamic>;
      return DetailsImagePage(
        wallpapers: args['wallpapers'],
        initialIndex: args['index'],
      );
    }),
);
