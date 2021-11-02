import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiu_jitsu_para_todos/src/shared/admob/controller/admob_controller.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:easy_localization/easy_localization.dart';

class DetailsImage extends StatefulWidget {
  final String imagePath;
  final int index;

  const DetailsImage({required this.imagePath, required this.index});

  @override
  _DetailsImageState createState() => _DetailsImageState();
}

class _DetailsImageState extends State<DetailsImage> {
  @override
  void didChangeDependencies() {
    Admob.createInterstitialAd();
    super.didChangeDependencies();
  }

  //------------------------------------------------------------------------------
  Future<void> _showMyDialogsaveerro() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.background,
          actions: [
            TextButton(
              child: Text('text_popup_error'.tr()),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

//------------------------------------------------------------------------------
  Future<void> _showMyDialogsaveimage() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.background,
          actions: [
            TextButton(
              child: Text('text_popup_success'.tr()),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  void _saveImage(String imagePath) async {
    ByteData bytes = await rootBundle.load(imagePath);

    var result = await ImageGallerySaver.saveImage(bytes.buffer.asUint8List());
    if ((result['isSuccess']))
      _showMyDialogsaveimage();
    else
      _showMyDialogsaveerro();
  }

//------------------------------------------------------------------------------
  void onPressed(String imagePath) async {
    if (await Permission.storage.request().isGranted) {
      Admob.showInterstitialAd();
      Future.delayed(Duration(seconds: 3), () => _saveImage(imagePath));
    }
  }

//------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Hero(
                tag: 'logo${widget.index}',
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    image: DecorationImage(
                      image: AssetImage(widget.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 3.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 50.h,
                        width: 200.w,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              primary: Colors.white,
                              elevation: 7,
                              backgroundColor: AppColors.background,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              side: const BorderSide(color: Colors.white)),
                          onPressed: () => onPressed(widget.imagePath),
                          child: Center(
                            child: Text(
                              'button_save_image'.tr(),
                              style: TextStyle(fontSize: 16.sp),
                            ),
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
      ),
    );
  }
}
