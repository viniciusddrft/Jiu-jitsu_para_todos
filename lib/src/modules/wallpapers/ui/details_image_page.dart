import '../../../shared/plugins/wallpaper/wallpaper_setter.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiu_jitsu_para_todos/src/shared/components/admob_native_ad.dart';
import 'package:jiu_jitsu_para_todos/src/shared/l10n/app_localizations.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../shared/plugins/admob/admob_interactor.dart';
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
  late int _currentIndex = widget.initialIndex;
  bool _precached = false;

  // Largura de decodificação (em pixels físicos). A imagem ocupa a tela
  // inteira, então decodificá-la na resolução nativa do arquivo só
  // desperdiçaria memória — basta o tamanho da tela.
  int? _decodeWidth;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final size = MediaQuery.sizeOf(context);
    _decodeWidth = (size.width * MediaQuery.devicePixelRatioOf(context)).round();
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
    super.dispose();
  }

  void _setWallpaper({required WallpaperTarget target}) {
    admobInteractor.showInterstitialAd();
    WallpaperSetter.setFromUrl(widget.wallpapers[_currentIndex].url, target)
        .then((success) {
      if (success && mounted) _showDialogSuccess();
    });
  }

  void _showDialogSuccess() => showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.text_popup_saved),
            backgroundColor: AppColors.background,
          );
        },
      );

  // Botão de destino do wallpaper (tela inicial / bloqueio / ambas) com o
  // estilo compartilhado pelas três opções do diálogo.
  Widget _targetButton(WallpaperTarget target, String label) => OutlinedButton(
        style: OutlinedButton.styleFrom(
            fixedSize: const Size(200, 50),
            foregroundColor: Colors.white,
            elevation: 7,
            backgroundColor: AppColors.background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            side: const BorderSide(color: Colors.white)),
        onPressed: () => _setWallpaper(target: target),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.yatraOne(fontSize: 16),
          ),
        ),
      );

  void showDialogSetWallpaper() => showDialog<void>(
        context: context,
        builder: (BuildContext context) => FractionallySizedBox(
          heightFactor: 0.5,
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            backgroundColor: AppColors.background,
            title: Text(
              AppLocalizations.of(context)!.title_popup_wallpaper,
              style: GoogleFonts.ubuntu(),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _targetButton(
                  WallpaperTarget.home,
                  AppLocalizations.of(context)!.text_popup_set_home,
                ),
                _targetButton(
                  WallpaperTarget.lock,
                  AppLocalizations.of(context)!.text_popup_set_block,
                ),
                _targetButton(
                  WallpaperTarget.both,
                  AppLocalizations.of(context)!.text_popup_set_both,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  AppLocalizations.of(context)!.text_cancel,
                  style: GoogleFonts.ubuntu(),
                ),
              )
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      // Wallpaper em tela cheia; arraste para cima/baixo para trocar.
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: _pageController,
        itemCount: widget.wallpapers.length,
        onPageChanged: (i) {
          _currentIndex = i;
          _precacheAround(i);
        },
        itemBuilder: (context, i) => Hero(
          transitionOnUserGestures: true,
          tag: 'logo$i',
          child: Image(
            image: _imageProvider(widget.wallpapers[i].url),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            loadingBuilder: (ctx, child, progress) => progress == null
                ? child
                : const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
      // Botão "usar wallpaper" como pílula flutuante sobre a imagem,
      // centralizado acima do anúncio (libera a área antes ocupada por ele).
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final PermissionStatus status = await Permission.storage.status;
          if (status.isDenied) await Permission.storage.request();
          showDialogSetWallpaper();
        },
        backgroundColor: AppColors.background,
        foregroundColor: Colors.white,
        elevation: 7,
        shape: const StadiumBorder(side: BorderSide(color: Colors.white)),
        icon: const Icon(Icons.wallpaper_outlined),
        label: Text(
          AppLocalizations.of(context)!.text_popup_save_wallpaper,
          style: GoogleFonts.yatraOne(fontSize: 16),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: SizedBox(
        height: 75,
        child: AdmobNativeAd(
          factoryId: 'listTile',
          adUnitId: admobInteractor.nativeAdUnitIDListTile,
        ),
      ),
    );
  }
}
