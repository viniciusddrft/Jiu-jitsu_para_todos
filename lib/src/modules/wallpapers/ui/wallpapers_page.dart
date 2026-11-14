import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_ui/material_ui.dart';

import '../../../shared/components/app_top_bar.dart';
import '../../../shared/components/native_ad_slot.dart';
import '../../../shared/components/offline_state.dart';
import '../../../shared/l10n/app_localizations.dart';
import '../../../shared/plugins/admob/admob_interactor.dart';
import '../../../shared/shimmer/shimmer_effect.dart';
import '../../../shared/shimmer/shimmer_widget.dart';
import '../../../shared/themes/app_colors.dart';
import '../interactor/wallpaper_entity.dart';
import '../interactor/wallpaper_interactor.dart';
import '../interactor/wallpaper_state.dart';

class WallpapersPage extends StatefulWidget {
  const WallpapersPage({super.key});

  @override
  State<WallpapersPage> createState() => _WallpapersViewState();
}

class _WallpapersViewState extends State<WallpapersPage> {
  static const _gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
    childAspectRatio: 0.6,
  );
  static const _gridPadding = EdgeInsets.fromLTRB(16, 20, 16, 24);

  final _wallpaperInteractor = inject<WallpaperInteractor>();
  final admobInteractor = inject<AdmobInteractor>();

  bool _adRequested = false;

  @override
  void initState() {
    _wallpaperInteractor.loadWallpapers();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // didChangeDependencies pode disparar mais de uma vez; criar o anúncio só
    // uma vez para não disparar requests duplicados.
    if (!_adRequested) {
      _adRequested = true;
      admobInteractor.createInterstitialAd();
    }
  }

  @override
  void dispose() {
    _wallpaperInteractor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final decodeWidth = (MediaQuery.sizeOf(context).width /
            2 *
            MediaQuery.devicePixelRatioOf(context))
        .round();

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: () async =>
              _wallpaperInteractor.loadWallpapers(forceRefresh: true),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: AppTopBar(eyebrow: l10n.title_appbar_wallpapers),
              ),
              SliverToBoxAdapter(child: PageHeading(l10n.wallpapers_heading)),
              ValueListenableBuilder(
                valueListenable: _wallpaperInteractor,
                builder: (context, value, _) => switch (value) {
                  // Um único Shimmer envolve a grade inteira: 1 controller e 1
                  // ShaderMaskLayer por frame, em vez de um por placeholder.
                  WallpaperLoading() => SliverPadding(
                      padding: _gridPadding,
                      sliver: SliverToBoxAdapter(
                        child: Shimmer(
                          gradient: ShimmerWidget.shimmerGradient,
                          period: const Duration(seconds: 3),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 4,
                            gridDelegate: _gridDelegate,
                            itemBuilder: (_, __) => ShimmerWidget(
                              width: double.infinity,
                              height: double.infinity,
                              shapeBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  WallpaperFailed() => SliverFillRemaining(
                      hasScrollBody: false,
                      child: OfflineState(
                        onRetry: () => _wallpaperInteractor.loadWallpapers(
                            forceRefresh: true),
                      ),
                    ),
                  WallpaperSuccess(
                    wallpapers: final List<WallpaperEntity> wallpapers
                  ) =>
                    SliverPadding(
                      padding: _gridPadding,
                      sliver: SliverGrid.builder(
                        gridDelegate: _gridDelegate,
                        itemCount: wallpapers.length,
                        itemBuilder: (context, index) => _Thumbnail(
                          index: index,
                          url: wallpapers[index].url,
                          decodeWidth: decodeWidth,
                          onTap: () => context
                              .pushNamed('/wallpaper/detailsimage', arguments: {
                            'index': index,
                            'wallpapers': wallpapers,
                          }),
                        ),
                      ),
                    ),
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NativeAdSlot(),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({
    required this.index,
    required this.url,
    required this.decodeWidth,
    required this.onTap,
  });

  final int index, decodeWidth;
  final String url;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Hero(
        transitionOnUserGestures: true,
        tag: 'logo$index',
        child: Material(
          color: AppColors.surfaceHigh,
          borderRadius: BorderRadius.circular(20),
          clipBehavior: Clip.antiAlias,
          child: Ink.image(
            // Decodifica na largura exibida (meia tela × DPR), não na
            // resolução cheia do wallpaper: grande economia de RAM.
            image: ResizeImage(NetworkImage(url), width: decodeWidth),
            fit: BoxFit.cover,
            child: InkWell(onTap: onTap),
          ),
        ),
      );
}
