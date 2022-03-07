import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/shared/admob/controller/admob_controller.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../shared/admob/widget/admob_native_ad.dart';

class JiujitsuinBrazil extends StatefulWidget {
  const JiujitsuinBrazil({Key? key}) : super(key: key);
  @override
  _JiujitsuinBrazilState createState() => _JiujitsuinBrazilState();
}

class _JiujitsuinBrazilState extends State<JiujitsuinBrazil> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          AppLocalizations.of(context)!.title_appbar_jiujitsu_in_brazil_page,
          style: TextStyle(fontFamily: 'YatraOne', color: Colors.grey[700]),
        ),
      ),
      backgroundColor: AppColors.background,
      body: SizedBox(
        width: _size.width,
        height: _size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: _size.width * 0.9,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: _size.height * 0.03),
                      child: Text(
                        AppLocalizations.of(context)!
                            .text_jiujitsu_in_brazil_paragraph1,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!
                          .text_jiujitsu_in_brazil_paragraph2,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      AppLocalizations.of(context)!
                          .text_jiujitsu_in_brazil_paragraph3,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
