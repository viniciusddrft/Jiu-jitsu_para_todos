import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiu_jitsu_para_todos/src/shared/l10n/app_localizations.dart';
import '../../../../shared/components/admob_native_ad.dart';
import '../../../../shared/plugins/admob/admob_interactor.dart';
import '../../../../shared/themes/app_colors.dart';

class JiujitsuInJapanView extends StatelessWidget {
  const JiujitsuInJapanView({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final admobInteractor = Modular.get<AdmobInteractor>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          AppLocalizations.of(context)!.title_appbar_jiujitsu_in_japan_page,
          style: GoogleFonts.yatraOne(color: Colors.grey[700]),
        ),
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.03),
                    child: Text(
                      AppLocalizations.of(context)!
                          .text_jiujitsu_in_japan_paragraph1,
                      style: GoogleFonts.ubuntu(fontSize: 16),
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!
                        .text_jiujitsu_in_japan_paragraph2,
                    style: GoogleFonts.ubuntu(fontSize: 16),
                  ),
                  Text(
                    AppLocalizations.of(context)!
                        .text_jiujitsu_in_japan_paragraph3,
                    style: GoogleFonts.ubuntu(fontSize: 16),
                  ),
                  Text(
                    AppLocalizations.of(context)!
                        .text_jiujitsu_in_japan_paragraph4,
                    style: GoogleFonts.ubuntu(fontSize: 16),
                  ),
                  Text(
                    AppLocalizations.of(context)!
                        .text_jiujitsu_in_japan_paragraph5,
                    style: GoogleFonts.ubuntu(fontSize: 16),
                  ),
                  Text(
                    AppLocalizations.of(context)!
                        .text_jiujitsu_in_japan_paragraph6,
                    style: GoogleFonts.ubuntu(fontSize: 16),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: size.height * 0.05),
                    child: Text(
                      AppLocalizations.of(context)!
                          .text_jiujitsu_in_japan_paragraph7,
                      style: GoogleFonts.ubuntu(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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
