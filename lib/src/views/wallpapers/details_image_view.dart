import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiu_jitsu_para_todos/src/controllers/admob/admob_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class DetailsImage extends StatelessWidget {
  final String imagePath;
  final index;

  DetailsImage({this.imagePath, this.index});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
//------------------------------------------------------------------------------
    Future<void> _showMyDialogsaveerro() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: [
              TextButton(
                child: Text('Aconteceu algum erro :/'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
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
            actions: [
              TextButton(
                child: Text('Imagem salva com sucesso!!!'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    void _saveimage(String imagePath) async {
      ByteData bytes = await rootBundle.load(imagePath);
      var result = await ImageGallerySaver.saveImage(
        bytes.buffer.asUint8List(),
      );
      if ((result['isSuccess'])) {
        _showMyDialogsaveimage();
      } else {
        _showMyDialogsaveerro();
      }
    }

//------------------------------------------------------------------------------
    void onpressed(String imagePath) async {
      if (await Permission.storage.request().isGranted) {
        Admob.showInterstitialAd();
        Future.delayed(Duration(seconds: 3), () {
          _saveimage(imagePath);
        });
      }
    }

//------------------------------------------------------------------------------
    return Scaffold(
      backgroundColor: Color(0xff202848),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Hero(
                tag: 'logo$index',
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
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
                              backgroundColor: Color(0xff202848),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              side: BorderSide(color: Colors.white)),
                          onPressed: () => onpressed(imagePath),
                          child: Center(
                            child: Text('Salvar imagem'),
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
