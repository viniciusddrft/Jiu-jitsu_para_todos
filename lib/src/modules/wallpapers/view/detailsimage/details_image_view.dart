import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiu_jitsu_para_todos/src/shared/admob/controller/admob_controller.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';
import 'package:permission_handler/permission_handler.dart';

class DetailsImage extends StatefulWidget {
  final String imageUrl;
  final int index;

  const DetailsImage({super.key, required this.imageUrl, required this.index});

  @override
  State<DetailsImage> createState() => _DetailsImageState();
}

class _DetailsImageState extends State<DetailsImage> {
  late final Size size = MediaQuery.of(context).size;

  @override
  void didChangeDependencies() {
    precacheImage(Image.network(widget.imageUrl).image, context);
    AdmobController.of(context).createInterstitialAd();
    super.didChangeDependencies();
  }

  Future<void> _showMyDialogSaveErro() async => showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppColors.background,
            actions: [
              TextButton(
                child: Text(AppLocalizations.of(context)!.text_popup_error),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );

  Future<void> _showMyDialogSaveImage() async => showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppColors.background,
            actions: [
              TextButton(
                child: Text(AppLocalizations.of(context)!.text_popup_success),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );

  void _saveImage() => GallerySaver.saveImage(widget.imageUrl).then(
        (bool? isSuccess) {
          if (isSuccess != null && isSuccess) {
            _showMyDialogSaveImage();
          } else {
            _showMyDialogSaveErro();
          }
        },
      );

  void onPressed() async {
    if (await Permission.storage.request().isGranted) {
      AdmobController.of(context).showInterstitialAd();
      Future.delayed(const Duration(seconds: 1), () => _saveImage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.7,
            child: Hero(
              tag: 'logo${widget.index}',
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(widget.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          fixedSize: const Size(200, 50),
                          foregroundColor: Colors.white,
                          elevation: 7,
                          backgroundColor: AppColors.background,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          side: const BorderSide(color: Colors.white)),
                      onPressed: onPressed,
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.button_save_image,
                          style: GoogleFonts.yatraOne(fontSize: 16),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
