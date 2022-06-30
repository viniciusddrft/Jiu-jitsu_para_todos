import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:jiu_jitsu_para_todos/src/shared/admob/controller/admob_controller.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';
import 'package:permission_handler/permission_handler.dart';

class DetailsImage extends StatefulWidget {
  final String imagePath;
  final int index;

  const DetailsImage({super.key, required this.imagePath, required this.index});

  @override
  State<DetailsImage> createState() => _DetailsImageState();
}

class _DetailsImageState extends State<DetailsImage> {
  @override
  void didChangeDependencies() {
    AdmobController.createInterstitialAd();
    super.didChangeDependencies();
  }

  //------------------------------------------------------------------------------
  Future<void> _showMyDialogSaveErro() async {
    return showDialog<void>(
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
  }

//------------------------------------------------------------------------------
  Future<void> _showMyDialogSaveImage() async {
    return showDialog<void>(
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
  }

  void _saveImage() async {
    final ByteData bytes = await rootBundle.load(widget.imagePath);

    var result = await ImageGallerySaver.saveImage(bytes.buffer.asUint8List());

    if ((result['isSuccess'])) {
      _showMyDialogSaveImage();
    } else {
      _showMyDialogSaveErro();
    }
  }

//------------------------------------------------------------------------------
  void onPressed() async {
    if (await Permission.storage.request().isGranted) {
      AdmobController.showInterstitialAd();
      Future.delayed(const Duration(seconds: 1), () => _saveImage());
    }
  }

//------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(
            child: Hero(
              tag: 'logo${widget.index}',
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  image: DecorationImage(
                    image: NetworkImage(widget.imagePath),
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
                          primary: Colors.white,
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
                          style: const TextStyle(fontSize: 16),
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
