import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/shared/admob/controller/admob_controller.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../shared/admob/widget/admob_native_ad.dart';
import '../../../../shared/launch_link/launch_link.dart';

class Cbjjrules extends StatefulWidget {
  const Cbjjrules({Key? key}) : super(key: key);
  @override
  _CbjjrulesState createState() => _CbjjrulesState();
}

class _CbjjrulesState extends State<Cbjjrules> with OpenLink {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          AppLocalizations.of(context)!.title_appbar_cbjj_rules_page,
          style: TextStyle(fontFamily: 'YatraOne', color: Colors.grey[700]),
        ),
      ),
      backgroundColor: AppColors.background,
      body: SizedBox(
        width: _size.width,
        height: _size.height,
        child: Column(
          children: [
            SizedBox(
              width: _size.width * 0.9,
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: _size.height * 0.03),
                    child: Text(
                      AppLocalizations.of(context)!.text_cbjj,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        fixedSize: const Size(200, 50),
                        elevation: 7,
                        primary: Colors.white,
                        backgroundColor: AppColors.background,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        side: const BorderSide(color: Colors.white)),
                    onPressed: () =>
                        openLink('https://cbjj.com.br/books-videos'),
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.text_button_cbjj,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 75,
        child: AdmobNativeAd(
          factoryId: 'listTile',
          adUnitId: AdmobController.nativeAdUnitIDListTile,
        ),
      ),
    );
  }
}
