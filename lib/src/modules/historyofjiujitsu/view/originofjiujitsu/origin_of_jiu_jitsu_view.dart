import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/shared/admob/controller/admob_controller.dart';
import 'package:jiu_jitsu_para_todos/src/shared/admob/widget/admob_native_ad.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OriginOfJiujitsu extends StatefulWidget {
  const OriginOfJiujitsu({Key? key}) : super(key: key);
  @override
  _OriginOfJiujitsuState createState() => _OriginOfJiujitsuState();
}

class _OriginOfJiujitsuState extends State<OriginOfJiujitsu> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          AppLocalizations.of(context)!.title_appbar_origin_of_jiujitsu_page,
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
                            .text_origin_of_jiujitsu_paragraph1,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!
                          .text_origin_of_jiujitsu_paragraph2,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      AppLocalizations.of(context)!
                          .text_origin_of_jiujitsu_paragraph3,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      AppLocalizations.of(context)!
                          .text_origin_of_jiujitsu_paragraph4,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: _size.height * 0.05),
                      child: Text(
                        AppLocalizations.of(context)!
                            .text_origin_of_jiujitsu_paragraph5,
                        style: const TextStyle(fontSize: 16),
                      ),
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
