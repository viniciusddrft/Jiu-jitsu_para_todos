import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_ui/material_ui.dart';
import 'package:jiu_jitsu_para_todos/src/modules/wallpapers/interactor/interfaces/ifirebase_wallpapers.dart';
import 'package:jiu_jitsu_para_todos/src/modules/wallpapers/interactor/wallpaper_interactor.dart';
import 'package:jiu_jitsu_para_todos/src/modules/wallpapers/interactor/wallpaper_entity.dart';
import 'package:jiu_jitsu_para_todos/src/modules/wallpapers/interactor/wallpaper_state.dart';
import 'package:jiu_jitsu_para_todos/src/modules/wallpapers/ui/wallpapers_page.dart';
import 'package:jiu_jitsu_para_todos/src/modules/wallpapers/ui/details_image_page.dart';
import 'package:jiu_jitsu_para_todos/src/shared/components/app_card.dart';
import 'package:jiu_jitsu_para_todos/src/shared/components/offline_state.dart';
import 'package:jiu_jitsu_para_todos/src/shared/l10n/app_localizations.dart';
import 'package:jiu_jitsu_para_todos/src/shared/plugins/admob/admob_interactor.dart';
import 'package:jiu_jitsu_para_todos/src/shared/shimmer/shimmer_widget.dart';
import '../support/test_app.dart';
import '../support/network_images.dart';

class GalleryRepository implements IFirebaseWallpapers {
  final refreshes = <bool>[];
  WallpaperState response = const WallpaperLoading();
  @override
  Future<WallpaperState> loadWallpapers({bool forceRefresh = false}) async {
    refreshes.add(forceRefresh);
    return response;
  }
}

const wallpapers = [
  WallpaperEntity(url: 'https://example.com/one.png'),
  WallpaperEntity(url: 'https://example.com/two.png'),
  WallpaperEntity(url: 'https://example.com/three.png')
];

void main() {
  setUp(() {
    mockAdsChannel();
    mockNetworkImages();
  });
  testWidgets('galeria apresenta loading, erro, imagens e força atualização',
      (tester) async {
    final repository = GalleryRepository();
    final interactor = WallpaperInteractor(firebaseWallpapers: repository);
    final ads = RecordingAds();
    await mount(tester, const WallpapersPage(),
        size: const Size(1000, 2400),
        register: (c) => c
          ..addInstance<WallpaperInteractor>(interactor)
          ..addInstance<AdmobInteractor>(ads));
    expect(find.byType(ShimmerWidget), findsWidgets);
    expect(ads.loads, 1);
    interactor.value = const WallpaperFailed();
    await tester.pump();
    expect(find.byType(OfflineState), findsOneWidget);
    repository.response = const WallpaperSuccess(wallpapers);
    interactor.loadWallpapers();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(Hero), findsNWidgets(3));
    final refresh =
        tester.widget<RefreshIndicator>(find.byType(RefreshIndicator));
    await refresh.onRefresh();
    await tester.pump();
    expect(repository.refreshes, [false, false, true]);
    expect(ads.loads, 1);
    await unmount(tester);
  });
  testWidgets('galeria envia imagem selecionada e lista à tela de detalhes',
      (tester) async {
    final repository = GalleryRepository()
      ..response = const WallpaperSuccess(wallpapers);
    Map<String, dynamic>? arguments;
    await mountRouter(
        tester,
        createModule(
            register: (c) => c
              ..addInstance<WallpaperInteractor>(
                  WallpaperInteractor(firebaseWallpapers: repository))
              ..addInstance<AdmobInteractor>(RecordingAds())
              ..route('/', child: (_, __) => const WallpapersPage())
              ..route('/wallpaper/detailsimage', child: (_, state) {
                arguments = state.arguments as Map<String, dynamic>;
                return const Text('Detalhes');
              })));
    await tester.pump();
    await tester.tap(find.byType(Hero).at(1));
    await tester.pump(const Duration(seconds: 1));
    await tester.pump();
    expect(arguments, {'index': 1, 'wallpapers': wallpapers});
    expect(find.text('Detalhes'), findsOneWidget);
    await unmount(tester);
  });
  testWidgets(
      'detalhes inicia no índice pedido, desliza e oferece destinos do wallpaper',
      (tester) async {
    await mount(
        tester, const DetailsImagePage(wallpapers: wallpapers, initialIndex: 1),
        size: const Size(1000, 1600),
        register: (c) => c.addInstance<AdmobInteractor>(RecordingAds()));
    final page = tester.widget<PageView>(find.byType(PageView));
    expect(page.controller!.page, 1);
    await tester.drag(find.byType(PageView), const Offset(0, -1200));
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));
    expect(page.controller!.page, 2);
    final l =
        AppLocalizations.of(tester.element(find.byType(DetailsImagePage)))!;
    await tester.tap(find.byType(AppButton));
    await tester.pump(const Duration(seconds: 1));
    expect(find.text(l.title_popup_wallpaper.toUpperCase()), findsOneWidget);
    expect(find.text(l.text_popup_set_home), findsOneWidget);
    expect(find.text(l.text_popup_set_block), findsOneWidget);
    expect(find.text(l.text_popup_set_both), findsOneWidget);
    // Fecha o painel tocando fora dele.
    await tester.tapAt(const Offset(500, 100));
    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(BottomSheet), findsNothing);
    await unmount(tester);
  });
}
