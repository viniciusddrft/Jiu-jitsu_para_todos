import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_ui/material_ui.dart';

import '../../../shared/components/app_card.dart';
import '../../../shared/components/native_ad_slot.dart';
import '../../../shared/l10n/app_localizations.dart';
import '../../../shared/plugins/admob/admob_interactor.dart';
import '../../../shared/plugins/haptics/app_haptics.dart';
import '../../../shared/plugins/wallpaper/wallpaper_setter.dart';
import '../../../shared/themes/app_colors.dart';
import '../../../shared/themes/app_text_styles.dart';
import '../interactor/wallpaper_entity.dart';

class DetailsImagePage extends StatefulWidget {
  final List<WallpaperEntity> wallpapers;
  final int initialIndex;

  const DetailsImagePage(
      {super.key, required this.wallpapers, required this.initialIndex});

  @override
  State<DetailsImagePage> createState() => _DetailsImagePageState();
}

class _DetailsImagePageState extends State<DetailsImagePage> {
  final admobInteractor = inject<AdmobInteractor>();
  late final PageController _pageController =
      PageController(initialPage: widget.initialIndex);
  late final _currentIndex = ValueNotifier<int>(widget.initialIndex);
  bool _precached = false;

  // Largura de decodificação (em pixels físicos). A imagem ocupa a tela
  // inteira, então decodificá-la na resolução nativa do arquivo só
  // desperdiçaria memória — basta o tamanho da tela.
  int? _decodeWidth;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final size = MediaQuery.sizeOf(context);
    _decodeWidth =
        (size.width * MediaQuery.devicePixelRatioOf(context)).round();
    if (!_precached) {
      _precached = true;
      _precacheAround(widget.initialIndex);
    }
  }

  // Provider único usado na exibição e no precache, para que ambos
  // compartilhem a mesma chave de cache e a imagem decodifique uma só vez.
  ImageProvider _imageProvider(String url) {
    final width = _decodeWidth;
    if (width == null) return NetworkImage(url);
    return ResizeImage(NetworkImage(url), width: width);
  }

  // Pré-carrega a página atual e os vizinhos para a troca ficar suave.
  void _precacheAround(int index) {
    for (final i in [index, index - 1, index + 1]) {
      if (i >= 0 && i < widget.wallpapers.length) {
        precacheImage(_imageProvider(widget.wallpapers[i].url), context);
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _currentIndex.dispose();
    super.dispose();
  }

  void _setWallpaper(WallpaperTarget target) {
    Navigator.pop(context);
    admobInteractor.showInterstitialAd();
    final l10n = AppLocalizations.of(context)!;
    WallpaperSetter.setFromUrl(
            widget.wallpapers[_currentIndex.value].url, target)
        .then((success) {
      if (!mounted) return;
      success ? AppHaptics.success() : AppHaptics.error();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
          children: [
            Icon(success ? Icons.check_circle_rounded : Icons.error_rounded,
                color: success ? AppColors.success : AppColors.accent),
            const SizedBox(width: 12),
            Expanded(
                child: Text(
                    success ? l10n.text_popup_saved : l10n.text_popup_error)),
          ],
        ),
      ));
    });
  }

  void _showTargetSheet() {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 14),
                child: Text(l10n.title_popup_wallpaper.toUpperCase(),
                    style: AppTextStyles.display(28)),
              ),
              Row(
                children: [
                  for (final (target, icon, label) in [
                    (
                      WallpaperTarget.home,
                      Icons.smartphone_rounded,
                      l10n.text_popup_set_home
                    ),
                    (
                      WallpaperTarget.lock,
                      Icons.lock_outline_rounded,
                      l10n.text_popup_set_block
                    ),
                    (
                      WallpaperTarget.both,
                      Icons.copy_all_rounded,
                      l10n.text_popup_set_both
                    ),
                  ]) ...[
                    if (target != WallpaperTarget.home)
                      const SizedBox(width: 8),
                    Expanded(
                      child: AppCard(
                        color: target == WallpaperTarget.both
                            ? AppColors.text
                            : AppColors.surfaceHigh,
                        radius: 18,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        onTap: () => _setWallpaper(target),
                        child: Column(
                          children: [
                            Icon(icon,
                                size: 26,
                                color: target == WallpaperTarget.both
                                    ? AppColors.background
                                    : AppColors.text),
                            const SizedBox(height: 10),
                            Text(label,
                                textAlign: TextAlign.center,
                                style: AppTextStyles.label(
                                    size: 13,
                                    color: target == WallpaperTarget.both
                                        ? AppColors.background
                                        : AppColors.text)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Wallpaper em tela cheia; arraste para cima/baixo para trocar.
          PageView.builder(
            scrollDirection: Axis.vertical,
            controller: _pageController,
            itemCount: widget.wallpapers.length,
            onPageChanged: (i) {
              _currentIndex.value = i;
              _precacheAround(i);
            },
            itemBuilder: (context, i) => Hero(
              transitionOnUserGestures: true,
              tag: 'logo$i',
              child: Image(
                image: _imageProvider(widget.wallpapers[i].url),
                fit: BoxFit.cover,
                loadingBuilder: (ctx, child, progress) => progress == null
                    ? child
                    : const Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  IconButton.filled(
                    tooltip:
                        MaterialLocalizations.of(context).backButtonTooltip,
                    onPressed: () => Navigator.of(context).maybePop(),
                    style: IconButton.styleFrom(
                        backgroundColor: const Color(0x990D1017),
                        foregroundColor: AppColors.text),
                    icon: const Icon(Icons.arrow_back_rounded),
                  ),
                  const Spacer(),
                  ValueListenableBuilder<int>(
                    valueListenable: _currentIndex,
                    builder: (_, index, __) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0x990D1017),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text('${index + 1} / ${widget.wallpapers.length}',
                          style: AppTextStyles.label(size: 12)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: AppButton(
              icon: Icons.wallpaper_outlined,
              label: l10n.text_popup_save_wallpaper,
              onPressed: _showTargetSheet,
            ),
          ),
        ],
      ),
      bottomNavigationBar: const ColoredBox(
        color: AppColors.background,
        child: NativeAdSlot(),
      ),
    );
  }
}
